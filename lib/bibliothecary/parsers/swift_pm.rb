module Bibliothecary
  module Parsers
    class SwiftPM
      include Bibliothecary::Analyser

      def self.mapping
        {
          match_filename("Package.swift", case_insensitive: true) => {
            kind: 'manifest',
            parser: :parse_package_swift,
            related_to: ['lockfile']
          },
          match_filename("Package.resolved", case_insensitive: true) => {
            kind: 'lockfile',
            parser: :parse_package_resolved,
            related_to: ['manifest']
          }
        }
      end

      add_multi_parser(Bibliothecary::MultiParsers::CycloneDX)
      add_multi_parser(Bibliothecary::MultiParsers::DependenciesCSV)
      add_multi_parser(Bibliothecary::MultiParsers::Spdx)

      def self.parse_package_swift(file_contents, options: {})
        response = Typhoeus.post("#{Bibliothecary.configuration.swift_parser_host}/to-json", body: file_contents, timeout: 60)
        raise Bibliothecary::RemoteParsingError.new("Http Error #{response.response_code} when contacting: #{Bibliothecary.configuration.swift_parser_host}/to-json", response.response_code) unless response.success?
        json = JSON.parse(response.body)
        json["dependencies"].map do |dependency|
          name = dependency["url"].gsub(/^https?:\/\//, "").gsub(/\.git$/,"")
          version = "#{dependency['version']['lowerBound']} - #{dependency['version']['upperBound']}"
          {
            name: name,
            requirement: version,
            type: "runtime",
          }
        end
      end

      def self.parse_package_resolved(file_contents, options: {})
        json = JSON.parse(file_contents)
        if json["version"] == 1
          json["object"]["pins"].map do |dependency|
            name = dependency['repositoryURL'].gsub(/^https?:\/\//, '').gsub(/\.git$/,'')
            version = dependency['state']['version']
            {
              name: name,
              requirement: version,
              type: 'runtime'
            }
          end
        else # version 2
          json["pins"].map do |dependency|
            name = dependency['location'].gsub(/^https?:\/\//, '').gsub(/\.git$/,'')
            version = dependency['state']['version']
            {
              name: name,
              requirement: version,
              type: 'runtime'
            }
          end
        end
        
      end
    end
  end
end

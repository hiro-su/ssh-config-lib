#encoding: utf-8
require "fileutils"

module SSH
  module Config
    module Update
      class << self
        attr_writer :config
        def read config=@config
          hash = {}
          open(config, "r") do |file|
            i,count= 0,0
            arr = [*file].map{|e| e.chomp!.split(" ", 2)}.flatten
            arr.delete ""

            raise ArgumentError, "invalid config format" if arr.length.odd?

            length = arr.find_all{|key| key =~ /^Host$/i }.length
            arr.each_with_index do |value, index|
              case value
              when /^Host$/i
                unless index.eql? 0
                  hash[arr[i+1]] = Hash[*arr[i..index-1]]
                  hash[arr[index+1]] = Hash[*arr[index..-1]] if count.eql? length-1
                end
                i = index
                count += 1
              end
            end
          end
          hash
        rescue TypeError => ex
          raise config.nil? ? "Please input config file" : ex
        end

        def update hash={}, api_data={}
          hash.each do |key,value|
            if api_data.include? key
              params = api_data[key].each_key.to_a
              params.each do |param|
                host_key = hash[key].select {|e| e =~ /^#{param}$/i }.keys.first
                host_key = param if host_key.nil?
                hash[key][host_key] = api_data[key][param]
              end
            end
          end
          hash
        rescue => ex
          raise ex
        end

        def write hash={}, config=@config
          data = ""
          hash.each_value do |v_hash|
            v_hash.each do |key, value|
              key = key =~ /^Host$/i ? key : format("%-13s", key)
              data << "#{key} #{value}\n"
            end
            data << "\n"
          end
          if File.exists?(config)
            FileUtils.mv config, "#{config}.#{Time.now.to_i}.bak"
            File.open(config, "w") {|file| file.write data.chomp }
          end
        rescue => ex
          raise ex
        end

        def run api_data={}
          write update(read, api_data)
        end
      end
    end
  end
end

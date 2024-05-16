
require 'net/http'
require 'json'

namespace :poses do
    desc "Fetch a list of poses from Pocket Yoga and create records in the database"
    task populate: :environment do
        url = URI('https://www.pocketyoga.com/poses.json')
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true if url.scheme == 'https'
        
        request = Net::HTTP::Get.new(url)
        
        response = http.request(request)
        
        if response.code == '200'
        poses = JSON.parse(response.body)
        poses.each do |pose|
            if YogaPose.exists?(name: pose['name'])
                puts "Skipping #{pose['name']} because it already exists"
                next
            end
                        
            yoga_pose_obj = YogaPose.create(
            name: pose['name'],
            difficulty: pose['difficulty'],
            benefits: pose['benefits'],
            category: pose['category'],
            description: pose['description'],
            display_name: pose['display_name'],
            )
            unless pose['aka'].nil?
                pose['aka'].each do |alt_name|
                    AlternativeName.create(name: alt_name, yoga_pose_id: yoga_pose_obj.id)
                end
            end
        end
        else
            puts "Error: #{response.code} - #{response.message}"
        end
    end
    task get_images: :environment do
        YogaPose.all.each do |pose|
            unless pose.image_url.nil?
                puts "Skipping #{pose.name} because it already has an image"
                next
            end
            url_str = "https://www.pocketyoga.com/assets/images/full/#{pose.name.gsub(" ", "")}.png" 
            url = URI(url_str)
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true if url.scheme == 'https'
            
            request = Net::HTTP::Get.new(url)
            
            response = http.request(request)
            
            if response.code == '200'
                pose.image_url = url_str
                pose.save
                puts "Saved image for #{pose.name}"
            elsif response.code == '404'
                url_str = "https://www.pocketyoga.com/assets/images/full/#{pose.name.gsub(" ", "")}_L.png"
                url = URI(url_str)
                http = Net::HTTP.new(url.host, url.port)
                http.use_ssl = true if url.scheme == 'https'
                request = Net::HTTP::Get.new(url)
                response = http.request(request)
                if response.code == '200'
                    pose.image_url = url_str
                    pose.save
                    puts "Saved image for #{pose.name}"
                else
                    puts "Couldn't find image for #{pose.name}"
                    next
                end
            else
                puts "Error: #{response.code} - #{response.message}"
            end
    end
    end
end


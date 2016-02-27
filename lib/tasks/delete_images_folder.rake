  task :delete_images_folder => :environment do

  	Dir.glob "./public/uploads/picture/image/*" do |dir|
  		
    	if Dir.entries(dir) - %w[ . .. ] == []
    		Dir.rmdir dir
    		puts "This directory is empty and for that reason, IT'S OUT!!!: " + dir.to_s
    	end

	end

    puts ""
	puts "This are our folders:"
	puts Dir.glob "./public/uploads/picture/image/*"
 end




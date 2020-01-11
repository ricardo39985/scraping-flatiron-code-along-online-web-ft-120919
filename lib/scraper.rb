require 'nokogiri'
require 'open-uri'
require "pry"

require_relative './course.rb'

class Scraper

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  def get_page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end

  def get_courses()
    get_page.css("article")
    # binding.pry

  end
  def make_courses
    get_courses.each do |article|
      new_course = Course.new
      new_course.title = article.css("h2").text
      new_course.schedule = article.css(".date").text
      new_course.description = article.css("p").text
      puts new_course.title

    end
    # binding.pry
  end
end
# binding.pry

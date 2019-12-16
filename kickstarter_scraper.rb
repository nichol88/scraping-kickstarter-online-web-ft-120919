# require libraries/modules here
require "nokogiri"
require "pry"

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  #binding.pry
  projects = kickstarter.css("li.project.grid_4")
  result = {}

  projects.each{ |project|
    title = project.css("h2.bbcard_name strong a").text
    result[title.to_sym] = {
      image_link: project.css("div.project-thumbnail a img").attribute("src").value,
      description: project.css("p.bbcard_blurb").text,
      location: project.css("li a").text.strip,
      percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }

  }
  # title: project.css("h2.bbcard_name strong a").text
  # image link: project.css("div.project-thumbnail a img").attribute("src").value
  # description: project.css("p.bbcard_blurb").text
  # location: project.css("li a").text.strip
  # percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i

  result
end

Gem::Specification.new do |s|
  s.name = "hn_reader"
  s.version = 0.01
  s.authors = ["Chris Bojemski"]
  s.email = ["chris.bojemski@gmail.com"]
  
  s.summary = "HNReader is a program that efficiently prints headlines from popular sites in your terminal"
  s.description = <<-DESCRIPTION
HeadliNeReader is a program that efficiently prints headlines from popular sites in your terminal.
It defaults to Hacker News (for which it was originally named), but you can choose between that, 
    - belong,
    - pinboard/popular,
    - github/trending

Soon, it will also support:
    - printing links only 
    - printing a specific headline, link, or both
    - printing a hyperlink whose text is the headline, but links to the site

Dream goals:
    - surf the comment section in the terminal from sites that support them
  DESCRIPTION

  s.homepage = "https://github.com/astrosquid/hn-reader"

  s.licenses = ["MIT"]

  s.files = `git ls-files`.split($\)
end

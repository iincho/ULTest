require 'yaml'
require 'pp'

str = File.read("universal_links_test.yml")
data = YAML.load(str)   # パースする

#domain
domain = data["domain"]
pc_domain = domain["pc"]
sp_domain = domain["sp"]

#uri
uri_data = data["uriData"]
out = ""
pc_html = ""
sp_html = ""
#pc

uri_data.each {|uri|
  if uri["pc"] == true
    full_url = "http://" + pc_domain + uri["uri"]
    pc_html << "<tr><td><a href='" + full_url + "'>" + uri["pageName"] + "</a></td><td>" + full_url + "</td></tr>\n"
  end
  if uri["sp"] == true
    full_url = "http://" + sp_domain + uri["uri"]
    sp_html << "<tr><td><a href='" + full_url + "'>" + uri["pageName"] + "</a></td><td>" + full_url + "</td></tr>\n"
  end
}

# output
out << "<html lang='ja'>\n"
out << "<head>\n"
out << "<meta charset='UTF-8'>\n"
out << "</head>\n"
out << "<body>\n"

out << "<h2>pc_domain</>\n"
out << "<table border='1' cellspacing='0'>\n"
out << pc_html
out << "</table>\n"

out << "<h2>sp_domain</>\n"
out << "<table border='1' cellspacing='0'>\n"
out << sp_html
out << "</table>\n"

out << "</body>\n"
out << "</html>\n"

#lender
file_path = "universal_links_test.html"

File.open(file_path,"w") do |file|
  file.puts out
end
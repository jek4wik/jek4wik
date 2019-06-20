module Jekyll
  class ContributionsPageGenerator < Generator
    def generate(site)
      site.data['authors'].each do |author|
        site.pages << ContributionsPage.new(site, author)
      end
    end
  end

  class ContributionsPage < Page
    def initialize(site, author)
      @site = site
      @base = site.source
      @name = "#{author['contributions_url']}"

      self.process(@name)
      self.read_yaml(File.join(@base, '_layouts'), 'contributions')
      self.data['author_full'] = author
      self.data['title'] = "Contributions by <a href=\"/#{site.data['i18n'][site.config['lang']]['prefix']['user']}#{author['id']}\">#{author['name']}</a>"
    end
  end
end
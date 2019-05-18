Jekyll::Hooks.register :site, :post_read do |site|
    user_pages = site.collections
        .select { |key, collection| key.start_with?('special') }
        .map { |key, collection| collection.docs }
        .flatten
        .select { |page| page.data['layout'] == 'user' }

    wiki_pages = site.collections
        .select { |key, collection| key.start_with?('wiki') }
        .map { |key, collection| collection.docs }
        .flatten
    site.data['wiki_pages'] = wiki_pages

    wiki_pages_hash = wiki_pages.map { |page| [page.id, page] }.to_h
    wiki_redirects = site.documents
        .select { |doc| doc.data['layout'] == 'redirect' }
    wiki_redirects.each { |page| page.data['redirect_target'] = wiki_pages_hash["/#{page.data['redirect'] || site.data['i18n'][site.config['lang']]['home']}"] }
    site.data['wiki_redirects'] = wiki_redirects

    wiki_tags = wiki_pages
        .map { |page| page.data['tags'] }
        .flatten
        .uniq
    site.data['wiki_tags'] = wiki_tags

    prefix = site.data['i18n'][site.config['lang']]['prefix']['user']
    authors = site.data['users'].map do |user|
        contributions = wiki_pages.select { |page| page.data['author'] == user[0] }
        author = {'id' => user[0], 
                  'name' => user[1]['name'], 
                  'logo' => user[1]['logo'], 
                  'url' => "/#{prefix}#{user[0]}",
                  'contributions' => contributions,
                  'contributions_count' => contributions.length,
                  'contributions_url' => "/#{prefix}#{user[0]}:Contributions"
                }
        user_pages.select { |page| page.url == author['url'] }
                  .each { |page| page.data['author_full'] = author }
        author
    end
    site.data['authors'] = authors

    wiki_pages.each do |page|
        page.data['author_full'] = authors.select { |author| author['id'] == page.data['author'] }.first
    end
end

Jekyll::Hooks.register :documents, :post_render do |doc|
    if doc.content then
        doc.data['size']=doc.content.size
        doc.data['bytes']=doc.content.bytesize
    else
        doc.data['size']=0
        doc.data['bytes']=0
    end
end

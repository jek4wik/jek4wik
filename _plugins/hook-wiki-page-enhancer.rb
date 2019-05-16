Jekyll::Hooks.register :documents, :pre_render do |post|
end

Jekyll::Hooks.register :documents, :post_render do |doc|
    # Jekyll.logger.info "Generating:", "Firing :pages, :post_render for : #{post.content}"
    if doc.content then
        doc.data['size']=doc.content.size
        doc.data['bytes']=doc.content.bytesize
    else
        doc.data['size']=0
        doc.data['bytes']=0
    end
end

xml.instruct!
xml.response do
  xml.status 'success'
  xml.items_returned @languages.size
  xml.items_available @languages.total_entries
  position = (@languages.current_page - 1) * @languages.per_page
  xml.first_item_position position
  xml.result do
    xml << (render partial: 'language', collection: @languages, locals: { builder: xml })
  end if @languages.present?
end

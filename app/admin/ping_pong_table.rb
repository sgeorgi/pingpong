ActiveAdmin.register PingPongTable do
  permit_params :street, :street_number, :postal_code, :city

  form do |f|
    f.inputs 'PingPongTable Details' do
      f.input :street
      f.input :street_number
      f.input :postal_code
      f.input :city
    end
    f.actions
  end

  index do |i|
    column 'Maps' do |ping_pong_table|
      link_to "[Google Maps]", "http://maps.google.com/?ll=#{ping_pong_table.latitude},#{ping_pong_table.longitude}", target: '_blank'
    end
    column :street
    column :street_number
    column :postal_code
    column :city
    actions
  end

 end

require 'sinatra'
require './rolodex'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String 

	# attr_accessor :id, :first_name, :last_name, :email, :note

	# def initialize (first_name, last_name, email, note)
	# 	@first_name = first_name
	# 	@last_name = last_name
	# 	@email = email
	# 	@note = note
	# end
end

DataMapper.finalize
DataMapper.auto_upgrade!


# end of datamapper setup

$rolodex = Rolodex.new

#begin sinatra routes

# $rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))

contact = $rolodex.find(1000)

get '/' do
	@crm_name = "My CRM"
	@title = "Sinatra"
	erb :index
end

get '/contacts' do 
	@contacts = Contact.all
	erb :contacts
end

get '/contacts/new' do
	@title = "New Contact"
	erb :new
end

get "/contacts/:id" do
  # @contact = $rolodex.find(params[:id].to_i)
  @contact = Contact.get(params[:id].to_i)
  if @contact
  	erb :show_contact
	else
		raise Sinatra::NotFound 
	end
end

get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]
    @contact.save

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    # $rolodex.remove_contact(@contact)
    @contact.destroy
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
 end

post '/contacts' do
	@title = "Contacts"
	new_contact = Contact.create(params)
	redirect to('/contacts')
end


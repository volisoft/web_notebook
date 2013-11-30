require 'bundler'
Bundler.require

class WebNotes < Sinatra::Base

  get '/?' do
    haml :index
  end

  get '/protected/notes/?' do
    @documents = Note.all(:user => current_user)
    haml :notes
  end

  get '/protected/new/?' do
    @document = Note.create
    haml :edit
  end

  get '/protected/view/:id' do
    @document = Note.get(params[:id])
    haml :edit
  end

  post '/protected/delete/:id' do
    @document = Note.get(params[:id])
    @document.destroy

    redirect '/protected/notes'
  end

  post '/protected/save/doc/?:id?' do
    note_info = params[:note]
    @document = Note.get(params[:id])
    if @document.nil?
      @document = Note.create(note_info)

      user = User.get(current_user.id)
      user.notes << @document
    else
      note_info[:updated_at] = Time.now
      @document.update(note_info)
    end

    if @document.save
      redirect "protected/notes"
    else
      redirect '/protected/new'
    end
  end

  post '/protected/search/?' do
    keyword = params[:keyword]
    @documents = Note.all(Note.user.id => current_user.id, :content.like => '%' + keyword + '%')
    haml :notes
  end

  get '/protected/settings/?' do
    haml :user_settings
  end

end
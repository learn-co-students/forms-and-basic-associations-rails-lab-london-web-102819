class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @genre_options = Genre.all.pluck(:name, :id).to_a
    @song = Song.new
    3.times {@song.notes << Note.new}
  end

  def create
    notes = song_params.delete(:notes)
    @song = Song.new(song_params)
    
    notes.each do |c|
      n = Note.create(content: c[:content])
      @song.notes << n
    end

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit!
  end
end

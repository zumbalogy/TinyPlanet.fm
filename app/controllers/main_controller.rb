class MainController < ApplicationController

    def test
        client = SoundCloud.new(:client_id => '4c2a3b5840e0236549608f59c2cd7d07')

        tracks = client.get('/tracks', q: params[:city], genres: params[:genre] )

        combo = Combo.new
        combo.city = params[:city]
        combo.genre = params[:genre]
        combo.save

        tracks.each do |track|
            foo = Song.new
            foo.combo_id = combo.id
            foo.name = track.title
            foo.url = track.uri
            foo.soundcloud_id = track.id
            foo.waveform_url = track.waveform_url
            foo.artwork_url = track.artwork_url
            foo.artist = track.user.username
            foo.save
        end

        respond_to do |format|
            format.json { render json: tracks.to_json }
        end
    end


    def index
    
    end

    def opinion
        foo = Opinion.new
        foo.song_id = Song.find(params[:song_id])
        foo.user_id = User.find(params[:user_id])
        foo.enjoyed = params[:opinion]
        foo.save
    end



end

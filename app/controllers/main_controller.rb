class MainController < ApplicationController

    def test
        client = SoundCloud.new(:client_id => '4c2a3b5840e0236549608f59c2cd7d07')

        tracks = client.get('/tracks', q: params[:city], genres: params[:genre] )
        respond_to do |format|
            format.json { render json: tracks.to_json }
        end
    end


    def index
    
    end

    def opinion
        song = Song.find(params[:song_id])
        user = User.find(params[:user_id])
        foo = Opinion.new
        foo.song = song
        foo.user = user
        foo.enjoyed? = params[:opinion]
        foo.save
    end



end

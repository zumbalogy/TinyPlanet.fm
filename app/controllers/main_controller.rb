class MainController < ApplicationController

    def test
          # need to make an ENV varabibe for the client id - MHP
        @client = SoundCloud.new(:client_id => '4c2a3b5840e0236549608f59c2cd7d07')
         # lets think about how we want to do this... --MHP
        @tracks = @client.get('/tracks', q: params[:city], genres: params[:genre], filter: 'streamable', limit: 1 )
        # do we then wsnt to make a playlist and pass in some songs of our own?
        # ie, @playlist = @tracks + .... 


        # I think combos should be saved when a user wants to save them, not before. 
        # Perhaps add a user id to the "combo" table? 
        # that way we can have a previously saved combos div
        # the creation should happen in the via and ajax call to the combo controller
        # - MHP
        # @combo = Combo.new
        # @combo.city = params[:city]
        # @combo.genre = params[:genre]
        # @combo.save!
         
            #Think about when we want to save songs, and what exactly we want to save.
           # Perhaps just the song name and song id? and throw this into the songs controller method
           # - MHP

        # @tracks.each do |track|
        #     song = Song.new
        #     song.combo_id = @combo.id

        #     song.name = track.title
        #     song.url = track.uri
        #     song.soundcloud_id = track.id
        #     song.waveform_url = track.waveform_url
        #     song.artwork_url = track.artwork_url
        #     song.artist = track.user.username
        #     song.save!
        # end

        respond_to do |format|
            format.json { render json: @tracks.to_json }
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

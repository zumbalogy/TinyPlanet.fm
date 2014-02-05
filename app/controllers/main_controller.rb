class MainController < ApplicationController

    def save
        check = Combo.where("city = ? AND genre = ?", params[:city],params[:genre])
        if check.length == 0
            @client = SoundCloud.new(:client_id => '4c2a3b5840e0236549608f59c2cd7d07')
            @tracks = @client.get('/tracks', q: params[:city], genres: params[:genre], filter: 'streamable')
     
            @combo = Combo.new
            @combo.city = params[:city]
            @combo.genre = params[:genre]
            @combo.save
    
            @tracks.each do |track|
                song = Song.new
                song.combo_id = @combo.id
                song.name = track.title
                song.url = "#{track.stream_url}?client_id=4c2a3b5840e0236549608f59c2cd7d07"
                song.soundcloud_id = track.id
                song.artwork_url = track.artwork_url
                song.artist = track.user.username
                song.save
            end
        end
        # respond_to do |format|
        #     format.json  { render :json => }
        # end
        redirect_to "/"
    end
    
    def serve
        @combo = Combo.where("city = ? AND genre = ?", params[:city],params[:genre])[0]
        @playlist = []
        @combo.songs.each do |song|
            if song.users.count == 0
                @playlist.push(song)
            else
                @playlist.unshift(song)
            end
        end
        respond_to do |format|
            format.json  { render :json => @playlist.to_json }
        end
    end

    

    def index
    end

    def opinion
        find = Opinion.where("song_id = ? AND user_id = ?", params[:song_id], params[:user_id])
        unless find
            foo = Opinion.new
            foo.song_id = Song.find(params[:song_id])
            foo.user_id = User.find(params[:user_id]) #current_user
            foo.enjoyed = true
            foo.save
        else
            find.delete
        end
        redirect_to "/"
    end
end

class MainController < ApplicationController

    def save
        check = true
        genre_check = Combo.find_by_genre(params[:genre])
        genre_check.each do |combo|
            if combo.city == params[:city]
                check = false
            end
        end
        if check
            @client = SoundCloud.new(:client_id => '4c2a3b5840e0236549608f59c2cd7d07')
            @tracks = @client.get('/tracks', q: params[:city], genres: params[:genre])
     
            @combo = Combo.new
            @combo.city = params[:city]
            @combo.genre = params[:genre]
            @combo.save
    
            @tracks.each do |track|
                song = Song.new
                song.combo_id = @combo.id
                song.name = track.title
                song.url = track.uri
                song.soundcloud_id = track.id
                song.waveform_url = track.waveform_url
                song.artwork_url = track.artwork_url
                song.artist = track.user.username
                song.save
            end
        end
    end
    
    def serve
        
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

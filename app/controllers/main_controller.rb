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
    else
      puts "already created!"
    end
    # head :created, location: @client
    render :nothing => true ## cause we dont need to render nada
  end
    
    def serve
        combo = Combo.where("city = ? AND genre = ?", params[:city],params[:genre])
        unliked = []
        liked = []
        high_count = 0
        combo.songs.each do |song|
            if song.users.count == 0
                unliked.push(song)
            else
                if song.users.count > high_count
                    high_count = song.users.count
                    liked << liked_most if liked_most
                    liked_most = song
                else
                    liked.push(song)
                end
            end
        end

      end
    end
    liked.shuffle!
    unliked.shuffle!
    rand_front = unliked.shift(liked.length * 2)
    rand_front += liked
    rand_front.shuffle!
    begin  ##error handling 
      rand_front.unshift(liked_most)
    rescue
      puts "No songs liked in this scene yet :("
    end
    @playlist = rand_front + unliked


    def index
    end

    def opinion
        find = Opinion.where("song_id = ? AND user_id = ?", params[:song_id], current_user)
        if find == []
            foo = Opinion.new
            foo.song_id = Song.find(params[:song_id])
            foo.user_id = User.find(current_user) 
            foo.enjoyed = true
            foo.save
        else
            find.delete
        end
    end

    def favorite
        find = Favorite.where("combo_id = ? AND user_id = ?", params[:combo_id], current_user))
        if find == []
            foo = Favorite.new
            foo.user_id = current_user
            foo.combo_id = params[:combo_id]
            foo.save
        else
            find[0].destroy
        end
    end
end

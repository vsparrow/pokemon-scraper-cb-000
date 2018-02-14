class Pokemon

  attr_accessor :id,:name,:type,:db ,:hp

  # def initialize(id=nil,name=nil,type=nil,db=nil,hp=60)
  def initialize(id=nil,name=nil,type=nil,db=nil,hp=nil)
    @id=id
    @name=name
    @type=type
    @db=db
    @hp=hp#default
    # @hp=db.execute("SELECT hp FROM pokemon WHERE id=#{@id}")

    if !db.nil?
      hp_found=nil;
      pragma=db.execute('PRAGMA table_info(pokemon)');
      pragma.each  {|hp| hp_found = true if hp[1]=="hp"}
      @hp=db.execute("SELECT hp FROM pokemon WHERE id=#{id}")[0][0] if hp_found == true;
      # puts "*******INIT:gettingHP"
    end

  end #initialize

  def self.save(name,type,db)
    pokemon_save= db.execute("INSERT INTO pokemon (name,type) VALUES (?,?)",name, type)
    # puts "*****************pokemon:#{pokemon_save}"
    # db.execute("UPDATE pokemon set  hp = 60 WHERE name = #{name};")
    # puts "**********************#{PRAGMA table_info(pokemon)}"
    # puts "**********************#{db.execute('PRAGMA table_info(pokemon)')}"
    hp_found=nil
    pragma=db.execute('PRAGMA table_info(pokemon)');
    # puts "************************#{pragma}"
    pragma.each  {|hp| hp_found = true if hp[1]=="hp"}
    # puts "**********************#{hp_found}"
    # puts "**********name:@#{name}"
    db.execute("UPDATE pokemon SET  hp = 60 WHERE name = '#{name}';") if hp_found == true;
    pokemon_save
  end #save

  def self.find(id,db)
    name = db.execute("SELECT name FROM pokemon WHERE id=#{id}")
    type = db.execute("SELECT type FROM pokemon WHERE id=#{id}")
    pokemon=self.new(id,name[0][0],type[0][0],db)  #not sure why need 2d array but returns coming in as [["Pikachu"]]
    hp_found=nil;
    pragma=db.execute('PRAGMA table_info(pokemon)');
    pokemon.hp=db.execute("SELECT hp FROM pokemon WHERE id=#{id}") if hp_found == true;
    pokemon
  end #find

  def alter_hp(hp,db)
    # puts "**************#{@id}"
    # puts "**************#{@name}"
    # puts "**************#{hp}"
    # puts "***********#{Pokemon.find(@id,db)}"
    # puts "***********#{Pokemon.find(@id,db).hp}"

    update=db.execute("UPDATE pokemon SET hp = #{hp} WHERE id = #{@id}")
    # puts ("UPDATE pokemon SET hp = #{hp} WHERE id = #{@id}")
    update=db.execute("UPDATE pokemon SET hp = #{hp} WHERE name = '#{@name}'")
    # puts "UPDATE pokemon SET hp = #{hp} WHERE name = '#{@name}'"
    # UPDATE cats SET name = "Hana" WHERE name = "Hannah";
    # puts ("SELECT hp FROM pokemon WHERE id=#{id}")
    # puts db.execute("SELECT hp FROM pokemon WHERE id=#{id}")
    # puts "***********#{update}"
    # puts "***********#{Pokemon.find(@id,db)}"
    # p=Pokemon.find(@id,db)
    # puts "***********pokemon.hp::#{Pokemon.find(@id,db).hp}::pokemon.name::#{p.name}::#{p.hp}"



  end #alter_hp
end

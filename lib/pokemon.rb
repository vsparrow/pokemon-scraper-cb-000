class Pokemon

  attr_accessor :id,:name,:type,:db

  def initialize(id=nil,name=nil,type=nil,db=nil)
    @id=id
    @name=name
    @type=type
    @db=db
  end #initialize

  def self.save(name,type,db)
    db.execute("INSERT INTO pokemon (name,type) VALUES (?,?)",name, type)
  end #save

  def self.find(id,db)
    name = db.execute("SELECT name FROM pokemon WHERE id=#{id}")
    type = db.execute("SELECT type FROM pokemon WHERE id=#{id}")
    pokemon=self.new(id,name[0][0],type[0][0])  #not sure why need 2d array but returns coming in as [["Pikachu"]]
  end #find
end

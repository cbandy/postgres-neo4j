require 'spec_helper'

describe 'http://neo4j.com/docs/2.1.1/cypherdoc-create-nodes-and-relationships/' do
  include_context 'connections'

  describe 'Create a node for the actor Tom Hanks' do
    before do
#      neo.execute_query %(CREATE (n:Actor { name:"Tom Hanks" }))
#      pg.exec %(
#        WITH
#        n AS (
#            INSERT INTO node (properties) VALUES ('name=>Tom Hanks') RETURNING id
#        )
#        INSERT INTO node_label VALUES (n.id, 'Actor');
#      )
    end

    it 'finds the node we created' do
      neo.execute_query %(
        CREATE (n:Actor { name:"Tom Hanks" })
      )
      result = neo.execute_query %(
        MATCH (actor:Actor { name: "Tom Hanks" })
        RETURN actor
      )

      expect(result['columns']).to eq ['actor']
      expect(result['data'].length).to eq 1
      expect(result['data'].first.first['data']).to eq('name' => 'Tom Hanks')
    end

    it 'creates a movie and connects it to the Tom Hanks node with an ACTED_IN relationship' do
      result = neo.execute_query %(
        MATCH (actor:Actor)
        WHERE actor.name = "Tom Hanks"
        CREATE (movie:Movie { title:'Sleepless IN Seattle' })
        CREATE (actor)-[:ACTED_IN]->(movie)
      )

      require 'pp'
      pp result
    end
  end
end

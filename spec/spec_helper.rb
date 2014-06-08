require 'neography'
require 'pg'

shared_context 'connections' do
  let(:neo) { Neography::Rest.new }
  let(:pg) { PG::Connection.new }

  before(:each) do
    neo.execute_query %(START n = node(*) OPTIONAL MATCH (n)-[r]-() WHERE id(n) <> 0 DELETE n,r)
#    pg.exec %(TRUNCATE node, node_label, relationship)
  end
end

#Neography.configure do |config|
#end

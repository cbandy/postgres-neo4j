-- vim: set et sw=2 ts=2 :

CREATE TABLE node (
  id serial PRIMARY KEY,
  properties hstore
);

CREATE TABLE node_label (
  node_id REFERENCES node,
  label text
);

CREATE TABLE relationship (
  id serial PRIMARY KEY,
  start_id integer REFERENCES node,
  end_id integer REFERENCES node,
  "type" text,
  properties hstore
);

CREATE INDEX ON relationship ("type", start_id);
CREATE INDEX ON relationship ("type", end_id);

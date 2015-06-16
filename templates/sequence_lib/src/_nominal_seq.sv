{% extends "_base.sv" %}

{% block body %}

// Nominal Seq -- just a wrapper for the item / driver interaction
//  simplifies the user api from start, finish, rand, get to just start
class {{ agent.name }}_nominal_seq extends uvm_sequence#({{ agent.name }}_item);
  `uvm_object_utils({{ agent.name }}_nominal_seq)

  // Rand Members
  // should match {{ agent.name }} item

  // Consraints
  //  if any..

  // Constructor
  function new(string name = "{{ agent.name }}_nominal_seq");
    super.new(name);
  endfunction: new

  // Sequence Body
  extern virtual task body();

endclass: {{ agent.name }}_nominal_seq

task {{ agent.name }}_nominal_seq::body();

  req = REQ::type_id::create("req", null, get_full_name());

  start_item(req);

  if (!req.randomize() with {
    // Constrain item with local rand variables
    // m_data == local::m_data;
  }) begin
    `uvm_fatal(get_name(), "randomize failed")
  end

  finish_item(req);

  get_response(rsp);

  m_rdata = rsp.m_rdata;

endtask: body

{% endblock %}

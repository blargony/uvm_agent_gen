{% extends "_base.sv" %}

{% block body %}

class {{ agent.name }}_agent extends uvm_agent;
  `uvm_component_utils({{ agent.name }}_agent)

  {{ agent.name }}_cfg m_cfg_h;

  // Analysis Fifos
  uvm_analysis_port#({{ agent.name }}_item) m_driver_req_analysis_port;
  uvm_analysis_port#({{ agent.name }}_item) m_driver_rsp_analysis_port;
  uvm_analysis_port#({{ agent.name }}_item) m_monitor_analysis_port;

  // Child Components
  {{ agent.name }}_sequencer m_{{ agent.name }}_sequencer;
  {{ agent.name }}_driver m_{{ agent.name }}_driver;
  {{ agent.name }}_monitor m_{{ agent.name }}_monitor;

  // Constructor
  function new(string name = "{{ agent.name }}_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  // Phase Methods
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass: {{ agent.name }}_agent

function void {{ agent.name }}_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db#({{ agent.name }}_cfg)::get(this, "", "{{ agent.name }}_cfg", m_cfg_h)) begin
    `uvm_fatal(get_name(), "Failed to Grab {{ agent.name }}_cfg from Config DB")
  end

  if (m_cfg_h.m_uvm_active_passive_h == UVM_ACTIVE) begin
    m_{{ agent.name }}_sequencer = {{ agent.name }}_sequencer::type_id::create("m_{{ agent.name }}_sequencer", this);
    m_{{ agent.name }}_driver = {{ agent.name }}_driver::type_id::create("m_{{ agent.name }}_driver", this);
    m_driver_req_analysis_port = new("m_driver_req_analysis_port", this);
    m_driver_rsp_analysis_port = new("m_driver_rsp_analysis_port", this);
  end

  m_{{ agent.name }}_monitor = {{ agent.name }}_monitor::type_id::create("m_{{ agent.name }}_monitor", this);
  m_monitor_analysis_port = new("m_monitor_analysis_port", this);

endfunction: build_phase


function void {{ agent.name }}_agent::connect_phase(input uvm_phase phase);
  super.connect_phase(phase);

  // Connect
  if (m_cfg_h.m_uvm_active_passive_h == UVM_ACTIVE) begin
    m_{{ agent.name }}_driver.seq_item_port.connect(m_{{ agent.name }}_sequencer.seq_item_export);
    m_{{ agent.name }}_driver.m_req_analysis_port.connect(m_driver_req_analysis_port);
    m_{{ agent.name }}_driver.m_rsp_analysis_port.connect(m_driver_rsp_analysis_port);
  end

  m_{{ agent.name }}_monitor.m_analysis_port.connect(m_monitor_analysis_port);

endfunction: connect_phase

{% endblock %}

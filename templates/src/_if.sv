{% extends "_base.sv" %}

{% block body %}
`timescale 1ns/1ps

interface {{ agent.name }}_if(input bit clk_i);

  // Interface Net Declarations

  clocking drv_cb @(posedge clk_i);
    default input #1step output #1ns;

    // Interface Clocked Driver Direction Declarations
    // input  example_net;
    // output  example_net;

  endclocking: drv_cb

  clocking mon_cb @(posedge clk_i);
    default input #1step;

    // Interface Clocked Monitor Direction Declarations
    // input  example_net;
    // input  example_net;

  endclocking: mon_cb

  modport drv_mp (
    clocking drv_cb,

    // Interface Async Driver Direction Declarations
    // async ports - for initializing pre-clock
    // output  example_net,
  );

  modport mon_mp (
    clocking mon_cb
  );

endinterface: {{ agent.name }}_if

{% endblock %}

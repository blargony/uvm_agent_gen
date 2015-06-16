{% extends "_base.sv" %}

{% block body %}

package {{ agent.name }}_pkg;

  // Custom Types

  // Include the Agent files
  `include "{{ agent.name }}_item.sv"
  `include "{{ agent.name }}_cfg.sv"
  `include "{{ agent.name }}_sequencer.sv"
  `include "{{ agent.name }}_driver.sv"
  `include "{{ agent.name }}_monitor.sv"
  `include "{{ agent.name }}_agent.sv"
  `include "{{ agent.name }}_sequence_list.sv"

endpackage: {{ agent.name }}_pkg

{% endblock %}

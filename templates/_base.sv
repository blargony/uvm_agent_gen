{% block copyright %}
//-----------------------------------------------------------------------------
// Insert Prefered CopyRight Here
//-----------------------------------------------------------------------------
{% endblock %}

/**
 * UVM Agent - {{ agent.name }}
 *
 *
 *
 * @file {{ agent.name }}{{ agent.file }}.sv
 * @author {{ agent.author }}
 * @par Contact:
 * {{ agent.email }}
 * @par Company:
 * <a href="http://{{ agent.href }}">{{ agent.company }}</a>
 *
 */

 * Generated File

`ifndef {{ agent.name|upper }}{{ agent.file|upper }}__SV
`define {{ agent.name|upper }}{{ agent.file|upper }}__SV

{% block body %}
{% endblock %}

`endif // {{ agent.name|upper }}{{ agent.file|upper }}__SV

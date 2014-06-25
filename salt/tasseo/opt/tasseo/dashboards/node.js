{% set items = salt['mine.get'](minion, 'grains.item')[minion] -%}
var metrics =
[
  {% for cpu in range(items.num_cpus) -%}
  {
    "alias":  "{{ minion }}: cpu-{{ loop.index0 }} idle",
    "target": "{{ minion }}.system.cpu-{{ loop.index0 }}.cpu-idle"
  },
  {
    "alias":  "{{ minion }}: cpu-{{ loop.index0 }} interrupt",
    "target": "{{ minion }}.system.cpu-{{ loop.index0 }}.cpu-interrupt"
  },
  {
    "alias":  "{{ minion }}: cpu-{{ loop.index0 }} nice",
    "target": "{{ minion }}.system.cpu-{{ loop.index0 }}.cpu-nice"
  },
  {
    "alias":  "{{ minion }}: cpu-{{ loop.index0 }} softirq",
    "target": "{{ minion }}.system.cpu-{{ loop.index0 }}.cpu-softirq"
  },
  {
    "alias":  "{{ minion }}: cpu-{{ loop.index0 }} steal",
    "target": "{{ minion }}.system.cpu-{{ loop.index0 }}.cpu-steal"
  },
  {
    "alias":  "{{ minion }}: cpu-{{ loop.index0 }} system",
    "target": "{{ minion }}.system.cpu-{{ loop.index0 }}.cpu-system"
  },
  {
    "alias":  "{{ minion }}: cpu-{{ loop.index0 }} user",
    "target": "{{ minion }}.system.cpu-{{ loop.index0 }}.cpu-user"
  },
  {
    "alias":  "{{ minion }}: cpu-{{ loop.index0 }} wait",
    "target": "{{ minion }}.system.cpu-{{ loop.index0 }}.cpu-wait"
  },
  {% endfor -%}
  {% for nic in salt['mine.get'](minion, 'network.interfaces')[minion].iterkeys()|sort -%}
  {
    "alias":  "{{ minion }}: interface-{{ nic }} if_errors rx",
    "target": "{{ minion }}.system.interface-{{ nic }}.if_errors.rx"
  },
  {
    "alias":  "{{ minion }}: interface-{{ nic }} if_errors tx",
    "target": "{{ minion }}.system.interface-{{ nic }}.if_errors.tx"
  },
  {
    "alias":  "{{ minion }}: interface-{{ nic }} if_octets rx",
    "target": "{{ minion }}.system.interface-{{ nic }}.if_octets.rx"
  },
  {
    "alias":  "{{ minion }}: interface-{{ nic }} if_octets tx",
    "target": "{{ minion }}.system.interface-{{ nic }}.if_octets.tx"
  },
  {
    "alias":  "{{ minion }}: interface-{{ nic }} if_packets rx",
    "target": "{{ minion }}.system.interface-{{ nic }}.if_packets.rx"
  },
  {
    "alias":  "{{ minion }}: interface-{{ nic }} if_packets tx",
    "target": "{{ minion }}.system.interface-{{ nic }}.if_packets.tx"
  },
  {% endfor -%}
  {
    "alias":  "{{ minion }}: load longterm",
    "target": "{{ minion }}.system.load.load.longterm"
  },
  {
    "alias":  "{{ minion }}: load midterm",
    "target": "{{ minion }}.system.load.load.midterm"
  },
  {
    "alias":  "{{ minion }}: load shortterm",
    "target": "{{ minion }}.system.load.load.shortterm"
  },
  {
    "alias":  "{{ minion }}: memory buffered",
    "target": "{{ minion }}.system.memory.memory-buffered"
  },
  {
    "alias":  "{{ minion }}: memory cached",
    "target": "{{ minion }}.system.memory.memory-cached"
  },
  {
    "alias":  "{{ minion }}: memory free",
    "target": "{{ minion }}.system.memory.memory-free"
  },
  {
    "alias":  "{{ minion }}: memory used",
    "target": "{{ minion }}.system.memory.memory-used"
  },
  {
    "alias":  "{{ minion }}: swap cached",
    "target": "{{ minion }}.system.swap.swap-cached"
  },
  {
    "alias":  "{{ minion }}: swap free",
    "target": "{{ minion }}.system.swap.swap-free"
  },
  {
    "alias":  "{{ minion }}: swap used",
    "target": "{{ minion }}.system.swap.swap-used"
  },
  {
    "alias":  "{{ minion }}: swap io-in",
    "target": "{{ minion }}.system.swap.swap_io-in"
  },
  {
    "alias":  "{{ minion }}: swap io-out",
    "target": "{{ minion }}.system.swap.swap_io-out"
  }
];
var period  = 1440;
var toolbar = false;

{ nixosConfigurations, writeText }:

{
  backup = {
    hostNames = [ "backup.intr" ];
    publicKeyFile = writeText "backup.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL6+2glj3YytDgU7sPYkl4ujvzZH7+fYuaTkViWyuMac";
  };
  bareos = {
    hostNames = [ "bareos.intr" ];
    publicKeyFile = writeText "bareos.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvfnIhhOcbQvQuCOHkCFyvw/5hxIuCkGX3Hw5HeUsRU";
  };
  ci = {
    hostNames = [ "ci.intr" ];
    publicKeyFile = writeText "ci.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMuoVDym2GI2U57ibfQxrUSw0Tn354aZf+Ojf3mKY43i";
  };
  dh1 = {
    hostNames = [ "dh1.intr" ];
    publicKeyFile = writeText "dh1.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1sT9eBoVq3s31h2rv3U13v+Yj3YKxNWlY86sLa2V+c";
  };
  dh2 = {
    hostNames = [ "dh2.intr" ];
    publicKeyFile = writeText "dh2.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMyhcM2Dw+OE1enixmnWZFJOXPhHmrBrh5Iwkj5vvjES";
  };
  dh3 = {
    hostNames = [ "dh3.intr" ];
    publicKeyFile = writeText "dh3.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMVuiCrPOgvtmFmQqOEofd4+LPs+s+NHi6NGk9BMYnh1";
  };
  dh4 = {
    hostNames = [ "dh4.intr" ];
    publicKeyFile = writeText "dh4.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIvLe8F4soEq06AUu87FfYegKFTMg0kITfam4jlSG6iV";
  };
  dh5 = {
    hostNames = [ "dh5.intr" ];
    publicKeyFile = writeText "dh5.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILSaHJIx32vWG8qVUk/AVnItveJDPzz2SYB4kRncASZY";
  };
  gitlab = {
    hostNames = [ "gitlab.intr" ];
    publicKeyFile = writeText "gitlab.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJw9vd+rL+MwVdVKSKW32+k6irAULLUFv5dmRUve2nUW";
  };
  jenkins = {
    hostNames = [ "jenkins.intr" ];
    publicKeyFile = writeText "jenkins.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGDngvW1IgUSW4Lna7tOoDBsC2sG+IlpDfYCe1wBVMp2";
  };
  kvm1 = {
    hostNames = [ "kvm1.intr" ];
    publicKeyFile = writeText "kvm1.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFs9K8r8X2tEfB42n17kT9zD17GZLIe+hncdUhGqf7rR";
  };
  kvm10 = {
    hostNames = [ "kvm10.intr" ];
    publicKeyFile = writeText "kvm10.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF9TBRKNGRrMWSpkfuuLzBrySm2hBZkF0LflHsLBHXTp";
  };
  kvm12 = {
    hostNames = [ "kvm12.intr" ];
    publicKeyFile = writeText "kvm12.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIrS2Ewhdo62C959LXtDyle2yEkr0ubd1ubvv3m1+9aj";
  };
  kvm13 = {
    hostNames = [ "kvm13.intr" ];
    publicKeyFile = writeText "kvm13.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA9cwZ8CG7hTT2B3MnDW/AFhADOBPdZoHhlqXl5JMz2Z";
  };
  kvm14 = {
    hostNames = [ "kvm14.intr" ];
    publicKeyFile = writeText "kvm14.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHNqf5mPe7hAUT6EDt56ai+aBoLjTTGNvwFcdDzuvLOK";
  };
  kvm15 = {
    hostNames = [ "kvm15.intr" "es2.intr" ];
    publicKeyFile = writeText "kvm15.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAiRHSHc2dew4YW4bRmkEycafLrBNELQPjh08LTjLBgA";
  };
  kvm16 = {
    hostNames = [ "kvm16.intr" ];
    publicKeyFile = writeText "kvm16.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOXuUSFXtjp4c2fWQKZVZmiPu0N1V7KpgnDj5KUeG7SK";
  };
  kvm17 = {
    hostNames = [ "kvm17.intr" ];
    publicKeyFile = writeText "kvm17.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG0SndMS+Hpinf9Un3AsVCauuETAf5xsDgeyB363oD+C";
  };
  kvm19 = {
    hostNames = [ "kvm19.intr" ];
    publicKeyFile = writeText "kvm19.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINIKvtXVgnV1ZkCSEnwaE5uzdMfoW/OxmP8SDFCi+6J0";
  };
  kvm2 = {
    hostNames = [ "kvm2.intr" ];
    publicKeyFile = writeText "kvm2.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvuddho76lwdOtSWmfgrBqIJ7cnbhyvQXXtjsCDezS2";
  };
  kvm20 = {
    hostNames = [ "kvm20.intr" ];
    publicKeyFile = writeText "kvm20.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHAihaTxMrCT1xPRWUkDQVJXDPBpI++VZkJv38y6pKVU";
  };
  kvm21 = {
    hostNames = [ "kvm21.intr" ];
    publicKeyFile = writeText "kvm21.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJhl/XKhw8n7MAVw1eTkXw5KTD0/LoWpMcZdZ2lveHA0";
  };
  kvm22 = {
    hostNames = [ "kvm22.intr" ];
    publicKeyFile = writeText "kvm22.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGpqMn+8O5UxZ4BPkN3kbLqh4qe0pLapRpRQW9Q9OKUH";
  };
  kvm23 = {
    hostNames = [ "kvm23.intr" ];
    publicKeyFile = writeText "kvm23.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGLjrNBaNQxTeIA2ARNjad6/U9mpYojTmdEbMBj8fybF";
  };
  kvm24 = {
    hostNames = [ "kvm24.intr" ];
    publicKeyFile = writeText "kvm24.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+aI/p1D4/7REPQby9beTud/1snks2s95OkOD2NKTNa";
  };
  kvm25 = {
    hostNames = [ "kvm25.intr" ];
    publicKeyFile = writeText "kvm25.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICDCHGldorlNs+PAIed5+P8ApBnTjFFU1/xtV03q1tCo";
  };
  kvm26 = {
    hostNames = [ "kvm26.intr" ];
    publicKeyFile = writeText "kvm26.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBvoI3Ld23dwOzo7WZ6p3hV0phKBI33iRiGvG5aiwPt";
  };
  kvm27 = {
    hostNames = [ "kvm27.intr" ];
    publicKeyFile = writeText "kvm27.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHJ0AW4LMg6Nu4Arrp67Eb+d0vZRJcTvmNyijyoQDSAR";
  };
  kvm28 = {
    hostNames = [ "kvm28.intr" ];
    publicKeyFile = writeText "kvm28.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINvSzYLUOZfJN0MoA79Zrne/Aaxipx0hraZjG0qeEORI";
  };
  kvm29 = {
    hostNames = [ "kvm29.intr" ];
    publicKeyFile = writeText "kvm29.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAzP3AGXAeB+ATh9eD/yYqe5ff0J/8yhukwE16d7IMf/";
  };
  kvm30 = {
    hostNames = [ "kvm30.intr" ];
    publicKeyFile = writeText "kvm30.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICNyaBarQtP9/UVrwdgsRyDbaOrxKx4pNhBMm6swp3zp";
  };
  kvm31 = {
    hostNames = [ "kvm31.intr" ];
    publicKeyFile = writeText "kvm31.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILr97FI4Hb6uRE9kJbMVsvsBCy0Cwf/YeT0IPvb8j4n7";
  };
  kvm32 = {
    hostNames = [ "kvm32.intr" ];
    publicKeyFile = writeText "kvm32.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGrfDF6qXpV+ASs7iOgqaahCDn0qVYyhlSsfdpI7QYAv";
  };
  kvm33 = {
    hostNames = [ "kvm33.intr" ];
    publicKeyFile = writeText "kvm33.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKqLD7q82L8eiQRW5TDQCUq/VentTGziPQAYOyoXBbxo";
  };
  kvm34 = {
    hostNames = [ "kvm34.intr" ];
    publicKeyFile = writeText "kvm34.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIASdbj9adxuQM8wjtXyoJoGgRo4NvR4BnpY1slyjIVxY";
  };
  kvm35 = {
    hostNames = [ "kvm35.intr" ];
    publicKeyFile = writeText "kvm35.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMBDHRvxaKCT5QYrYxLH0+eKL3kIYRSdPDyht+0Ye1OG";
  };
  kvm37 = {
    hostNames = [ "kvm37.intr" ];
    publicKeyFile = writeText "kvm37.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIV2eKWzOlBgv6UDRU2OrbE5K6ViQSUbEJe7J6EGi0Z6";
  };
  kvm5 = {
    hostNames = [ "kvm5.intr" ];
    publicKeyFile = writeText "kvm5.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDY6EtTDWG9N+NVcbEqRgZMO9w2k0T4+2GdZYBpsf9NC";
  };
  kvm6 = {
    hostNames = [ "kvm6.intr" ];
    publicKeyFile = writeText "kvm6.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4vWjgaI6FD1y2Ea+/BLLt5526VG3ouJQmNEhIJBAwA";
  };
  kvm9 = {
    hostNames = [ "kvm9.intr" ];
    publicKeyFile = writeText "kvm9.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGi1KuRoN0huS5T7gSAVgsI1MVKt3wdqcBqzSwSzyga0";
  };
  nginx1 = {
    hostNames = [ "nginx1.intr" ];
    publicKeyFile = writeText "nginx1.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDczVEhDo8nlzldJSCWzH+ePUt+5GZLtpdaf1jqlHEwv";
  };
  nginx2 = {
    hostNames = [ "nginx2.intr" ];
    publicKeyFile = writeText "nginx2.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC5t8krzyEilxCveL0mA85wPrayktXnqMA4lwLcCKNo7";
  };
  nginx3 = {
    hostNames = [ "nginx3.intr" ];
    publicKeyFile = writeText "nginx3.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFdqPFP16/C12LOgKVXbcvz0zP0l1unrqC1ogsXRp6h0";
  };
  mx2-mr = {
    hostNames = [ "mx2-mr.intr" ];
    publicKeyFile = writeText "mx2-mr.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP/35T/WQeT99SS9sXb9GGHUVDH4cpNe9x2pGcthU1ER";
  };
  pop1 = {
    hostNames = [ "pop1.intr" ];
    publicKeyFile = writeText "pop1.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwQvaJq/AvAHbGnwA5/wz6A6L/9d2ti6dfW0naw1XgS";
  };
  pop2 = {
    hostNames = [ "pop2.intr" ];
    publicKeyFile = writeText "pop2.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1pxA7ntoj3UrdnNa5iZyVeoYJpf/PNWOYaGVQFTC83";
  };
  pop5 = {
    hostNames = [ "pop5.intr" ];
    publicKeyFile = writeText "pop5.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOC9Km+6vSadrdKv08OnMB+J3ZjwHMYAEXnoW3HXYZZZ";
  };
  router1 = {
    hostNames = [ "router1.intr" ];
    publicKeyFile = writeText "router1.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILKuOkyy9BgHxBfhEFQxKX291FnRSOILUxjwZgm8tD/d";
  };
  router2 = {
    hostNames = [ "router2.intr" ];
    publicKeyFile = writeText "router2.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPs6TAjJkg8TBe0whA7CvsvaXJbIpviR34tlG0MzCTzf";
  };
  deprecated-web30 = {
    hostNames = [ "deprecated-web30.intr" "172.16.103.136" ];
    publicKeyFile = writeText "deprecated-web30.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDdts7IDmbD989bXhNtxA1kXm6+4CTeYXGQuC3neQGFc";
  };
  deprecated-web32 = {
    hostNames = [ "deprecated-web32.intr" "172.16.103.35" ];
    publicKeyFile = writeText "deprecated-web32.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdu5ZUZK2ARi8kOCjH5OhWK73gI+jIaAatJSGIIpUT9";
  };
  deprecated-web34 = {
    hostNames = [ "deprecated-web34.intr" "172.16.103.34" ];
    publicKeyFile = writeText "deprecated-web34.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBY+LXRT03nGlp29NXUYO8/G/h3LbWB2plHZoMJgb8Kv";
  };
  deprecated-web15 = {
    hostNames = [ "deprecated-web15.intr" "172.16.103.34" ];
    publicKeyFile = writeText "deprecated-web15.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICuHU0kawpIccDN0WXFppxsUCR9OO+Kac7rz2Tn3NYS+";
  };
  web15 = {
    hostNames = [ "web15.intr" ];
    publicKeyFile = writeText "web15.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0HPsEIKEMnR+kYBr1vgkUvtKkRT534NL/uSyKCNvJ0";
  };
  web16 = {
    hostNames = [ "web16.intr" ];
    publicKeyFile = writeText "web16.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAvpzS5R00ZiCAqtgT3533VqBRpIoh4XrZRuSn24DRSB";
  };
  web17 = {
    hostNames = [ "web17.intr" ];
    publicKeyFile = writeText "web17.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICnW97tWV7Zw01zyyheBmZ5WaQd/Yw4HG94yYoLrJo6C";
  };
  web18 = {
    hostNames = [ "web18.intr" ];
    publicKeyFile = writeText "web18.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMsYwsTzy/rYzwpUWM9tX4NnRnJL1YenHH5BQu3LozXQ";
  };
  web19 = {
    hostNames = [ "web19.intr" ];
    publicKeyFile = writeText "web19.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDxSKZXLn1s+CGY9/nKwTo3HYA5dj5THJbIoh0vDnx8N";
  };
  web20 = {
    hostNames = [ "web20.intr" ];
    publicKeyFile = writeText "web20.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEVtAMfA9fTTjfOCpWFk04kU/dlXkco3++D5qVh8Es1E";
  };
  web21 = {
    hostNames = [ "web21.intr" ];
    publicKeyFile = writeText "web21.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGkroacXsngzOYXukFMan8F/+qDmMXU5rRrn+elpZfcA";
  };
  web22 = {
    hostNames = [ "web22.intr" ];
    publicKeyFile = writeText "web22.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICkmrKtjfO23ApT4fyli4ONiliteNhk7ud12nLqH1Mw9";
  };
  deprecated-web23 = {
    hostNames = [ "deprecated-web23.intr" "172.16.103.69" ];
    publicKeyFile = writeText "deprecated-web23.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN0lbZoEBB7tPcRWT8ChgBK1wYmtr9pTxlbsdEuszQiY";
  };
  web25 = {
    hostNames = [ "web25.intr" ];
    publicKeyFile = writeText "web25.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBVaPbk9hqgtjyn0x2p6uZu6/M0p+XJnRQ2NEwN4WvLq";
  };
  web26 = {
    hostNames = [ "web26.intr" ];
    publicKeyFile = writeText "web26.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKS8P9N9OjHnAZTJWLkVLBYgqzdPmzpmujS6KFHQpQn5";
  };
  web27 = {
    hostNames = [ "web27.intr" ];
    publicKeyFile = writeText "web27.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPfuQ3hn+lhsCvLM29YmfV4yAEQW5+b092NvEJkq93FI";
  };
  web28 = {
    hostNames = [ "web28.intr" ];
    publicKeyFile = writeText "web28.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOK7yg78Wt/RCprSaHIomVS6eX6DG7vW8yFQ6A87dYbO";
  };
  container-web28 = {
    hostNames = [ "container-web28.intr" "172.16.103.122" ];
    publicKeyFile = writeText "container-web28.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF0tBADmsd5xnztYXQWtbITJFlf4XQaUYjgUAD8qAWHE";
  };
  web29 = {
    hostNames = [ "web29.intr" ];
    publicKeyFile = writeText "web29.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC8KAzfJaQD7ZDfgh4D7PuEgAIihHo7/8pC8Hd/eeUSc";
  };
  deprecated-web31 = {
    hostNames = [ "deprecated-web31.intr" ];
    publicKeyFile = writeText "web31.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFGlpaxLdiimyb+HkeUftSU+hpQGBDsmarkAD1V0fxri";
  };
  web33 = {
    hostNames = [ "web33.intr" ];
    publicKeyFile = writeText "web33.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAisxyZRFSQRKelzLqezIXMnsdHOL4kj3aihOHm5UCs4";
  };
  container-web33 = {
    hostNames = [ "container-web33.intr" "172.16.103.124" ];
    publicKeyFile = writeText "container-web33.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJptvJpWFNeI2oh/hSYP4/y5sNKZNGawk6m1STiYlRM1";
  };
  web35 = {
    hostNames = [ "web35.intr" ];
    publicKeyFile = writeText "web35.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHlu+T1neLSC7/h/4lLR8NilE07NwNy4gJgiMJc/Q0F";
  };
  web36 = {
    hostNames = [ "web36.intr" ];
    publicKeyFile = writeText "web36.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFOFRAQIqaDp7ntVKu06JZ3fgwMHMKdUynfDY7YMSX8W";
  };
  web37 = {
    hostNames = [ "web37.intr" ];
    publicKeyFile = writeText "web37.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN4Jq6nmRgvwm0XTUrpfUj+53pNx04nOWeUs//ryga6a";
  };
  web38 = {
    hostNames = [ "web38.intr" ];
    publicKeyFile = writeText "web38.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK4+zDQ8cRF5W3hHFlftnd8OICK9Vf/VyUqNKDhiabp6";
  };
  web39 = {
    hostNames = [ "web39.intr" ];
    publicKeyFile = writeText "web39.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLk/W2v+06Wd4IlAefTJjjfmffbjyMSvk0lW8gEJnFf";
  };
  web40 = {
    hostNames = [ "web40.intr" ];
    publicKeyFile = writeText "web40.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB0jYkEZDOi3j3C+/SxavHBfKkVKkrhVISy+pmnaAITY";
  };
  web41 = {
    hostNames = [ "web41.intr" ];
    publicKeyFile = writeText "web41.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrwu6zz0Vz4lS9nKRCHm/GykZdolehpreHLAoGrjM4C";
  };
  web42 = {
    hostNames = [ "web42.intr" ];
    publicKeyFile = writeText "web42.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOmG7BqVoaY2QGtEb8R5wwotJCMhNuUydBpbsfeEiK14";
  };
  web43 = {
    hostNames = [ "web43.intr" ];
    publicKeyFile = writeText "web43.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMiH1LU+Xs6br/50px8/dK3bVNhtbogmApLUoIDRY0SQ";
  };
  web98 = {
    hostNames = [ "web98.intr" ];
    publicKeyFile = writeText "web98.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBA2ndToN39OkURjT651QwfFAW8aQLed6cpAAioKpWVt";
  };
  container-web15 = {
    hostNames = [ "container-web15.intr" "172.16.103.15" ];
    publicKeyFile = writeText "container-web15.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP0HPsEIKEMnR+kYBr1vgkUvtKkRT534NL/uSyKCNvJ0";
  };
  container-web23 = {
    hostNames = [ "container-web23.intr" "172.16.103.67" ];
    publicKeyFile = writeText "container-web23.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcjIilVAjZwaG6CJRmtRKF3ep6Rb7ni5BwJLcF+SHP6";
  };
  container-web30 = {
    hostNames = [ "container-web30.intr" "172.16.103.14" "172.16.103.135" ];
    publicKeyFile = writeText "container-web30.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINJm2wnSG6haBYAzI7Az+zdMbtTeUhaCYKXb3n+HCC2e";
  };
  container-web31 = {
    hostNames = [ "container-web31.intr" "172.16.103.141" ];
    publicKeyFile = writeText "container-web31.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGdVaUpw17zg9sgDtvG0aQhjcTYdoNjU5IiagDLLe2l";
  };
  container-web32 = {
    hostNames = [ "container-web32.intr" "185.84.108.28" ];
    publicKeyFile = writeText "container-web32.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMf9W486kfN17a3XRS4UY0CQ0rCH2giSPra3oZSKiujS";
  };
  container-web34 = {
    hostNames = [ "container-web34.intr" "172.16.103.99" ];
    publicKeyFile = writeText "container-web34.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEjpfdpAaoSYtxFUuq8dLASOH4FkcM5OkZjGJLfkiJ9J";
  };
  container-web36 = {
    hostNames = [ "container-web36.intr" "172.16.103.36" ];
    publicKeyFile = writeText "container-web36.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIrcCNqQxgtA47+PxfFi9RFmpLTjzjWMG+a/DIk81oTG";
  };
  container-web99 = {
    hostNames = [ "container-web99.intr" "185.84.108.223" ];
    publicKeyFile = writeText "container-web99.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHYYVdm1qtD3+FyJAlEkKnr0MvAR9o0BVwy2dTHOZgj4";
  };
  webmail1 = {
    hostNames = [ "webmail1.intr" ];
    publicKeyFile = writeText "webmail1.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqshIuxkqMXa3/rg6pLBkOcfGNWCyuhwOOsAitmmeNV";
  };
  webmail2 = {
    hostNames = [ "webmail2.intr" ];
    publicKeyFile = writeText "webmail2.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBO6X+yRi7xbr8iqOT3th7frxf6vjvp08yqyGrbg7AXT";
  };
  webmail3 = {
    hostNames = [ "webmail3.intr" ];
    publicKeyFile = writeText "webmail3.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF4x35Z4qnL+uribDncs9aQOMAMOqKmjGE9ugDLEw3Be";
  };
  chef-server = {
    hostNames = [ "chef-server.intr" ];
    publicKeyFile = writeText "chef-server.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEio+hXB7WrQ8zxCSQXstZv9fL/23MHxZ4Tg4dMs38b";
  };
  fluentd = {
    hostNames = [ "fluentd.intr" ];
    publicKeyFile = writeText "fluentd.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDjaT3qWzQ74bXfqf8XhJE7bWi0Q7M+CAp4BGD1JXNGx";
  };
  staff = {
    hostNames = [ "staff.intr" ];
    publicKeyFile = writeText "staff.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMhMAuWky46KWGCtkjkpIYLXWXtpsQxRTlg4+rwDMNBN";
  };
  sup1 = {
    hostNames = [ "172.16.107.41" ];
    publicKeyFile = writeText "sup1.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQbrBq3ZuHO8j+iTi8e1OV3JFqtXLbmqxSoDO+YPjON";
  };
  sup2 = {
    hostNames = [ "172.16.107.42" ];
    publicKeyFile = writeText "sup2.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPfA7QfWl3O1o3Ek4mdNVL9RYDOYGSYozyx52ui6NHbq";
  };
  sup3 = {
    hostNames = [ "172.16.107.43" ];
    publicKeyFile = writeText "sup3.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDj4szVjJae1LQiHOj5b7+0+xWsrjfhNb/yv6O5CevIg";
  };
  sup4 = {
    hostNames = [ "172.16.107.44" ];
    publicKeyFile = writeText "sup4.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFhBBXj6kwe4nRmZXt5MNzJbL3X1AnSbUqhYUFE2eIdJ";
  };
} // (let
  ipAddress = host:
    (builtins.head
      nixosConfigurations.${host}.config.networking.interfaces.br0.ipv4.addresses).address;
in {
  ns1-dh = {
    hostNames = [ "ns1-dh.intr" (ipAddress "ns1-dh") ];
    publicKeyFile = writeText "ns1-dh.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO8rIJL2e6YdTv0c/f9D3WIah8cISFxJXGbvMJZRXUIJ";
  };
  ns1-mr = {
    hostNames = [ "ns1-mr.intr" (ipAddress "ns1-mr") ];
    publicKeyFile = writeText "ns1-mr.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICiJIUaThTHR+IdW283fLo6fX3M/a/meTH8kxtmEmFno";
  };
  ns2-dh = {
    hostNames = [ "ns2-dh.intr" (ipAddress "ns2-dh") ];
    publicKeyFile = writeText "ns2-dh.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKF1maL0yzCMHHu1zL32z6/jufehlR+byFu1uY3as82i";
  };
  ns2-mr = {
    hostNames = [ "ns2-mr.intr" (ipAddress "ns2-mr") ];
    publicKeyFile = writeText "ns2-mr.pub"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEQlrpFyq9rahU87YDNjL/+tNeMaYgTjWvbsD22KvnjX";
  };
})

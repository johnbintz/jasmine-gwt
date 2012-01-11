#= require jasmine/GWT
#= require jasmine/GWT/Feature
#= require jasmine/GWT/Background
#= require jasmine/GWT/Scenario
#= require jasmine/GWT/globals

for method, code of jasmine.GWT.globals
  (exports ? this)[method] = code


// Generated by LiveScript 1.4.0
(function(){
  var Dependency, Value;
  Dependency = require('./Dependency');
  Value = function(value){
    return function(){
      var dep, v, get;
      dep = new Dependency;
      v = value;
      get = function(){
        if (typeof v === 'function') {
          return v();
        } else {
          return v;
        }
      };
      return function(newV, hactive){
        hactive == null && (hactive = true);
        if (newV == null) {
          if (hactive) {
            dep._Depends();
          }
          return get();
        } else {
          v = newV;
          if (hactive) {
            dep._Changed();
          }
          return v;
        }
      };
    }();
  };
  module.exports = Value;
}).call(this);

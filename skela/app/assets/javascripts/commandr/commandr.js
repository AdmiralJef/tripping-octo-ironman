window.Commandr = (function(){
  function Commandr(){}

  var commandr = {
    registered: [],
    register: function(){
      // expects any number of strings, followed by a function
      for(var i = 0; i < arguments.length - 2; i++) {
        this.registered.push({"string":arguments[i],"command":arguments[arguments.length-1]});
      }
    },

    parse: function(string){
      // iterate through the registered functions, and do the ones that match
      for(i=0;i<this.registered.length;i++){
        if(("commander " + this.registered[i].string) == string){
          this.registered[i].command.call(window, string);
          return string;
        }
      }
      return null;
    }
  };

  return commandr;
}());



$(function(){
  var container = $('<div></div>').addClass('commander');
  var icon = $('<div></div>').addClass('commander-icon');
  var textContainer = $('<div></div>').addClass('commander-text-container');
  var pic = $('<img />').attr("src", "http://images.clipartpanda.com/radio-microphone-vector-RiGK4RoiL.png");
  var pic2 = $('<img />').attr("src", "http://png-4.findicons.com/files/icons/2768/freecns_cumulus/16/164_questionmark.png");
  var banner = $('<div></div>').addClass('commander-banner');
  var spoken = $('<div></div>').addClass('commander-spoken');
  var questionmark = $('<div></div>').addClass('commander-help');

  icon.append(pic);
  questionmark.append(pic2);
  container.append(icon);
  textContainer.append(banner);
  textContainer.append(spoken);
  container.append(textContainer);
  container.append(questionmark);

  container.css({
    position: 'fixed',
    top: 0,
    left: 0,
    right: 0,
    backgroundColor: '#ddd',
    width: '300px',
    height: '75px',
    border: '3px solid black',
    borderTop: 'none',
    marginLeft: 'auto',
    marginRight: 'auto',
    borderBottomRightRadius: '15px',
    borderBottomLeftRadius: '15px',
    boxShadow: '2px 2px 1px #888, 2px -2px 1px #888',
    zIndex: '50'
  });

  icon.css({
    display: 'inline-block',
    marginLeft: '20px',
    verticalAlign: 'top',
    marginTop: '10px'
  });

  pic.css({
    height: '45px'
  });

  banner.css({
    verticalAlign: 'top'
  });

  spoken.css({
    width: '200px',
    height: '10px',
    display: 'inline-block',
    fontWeight: 'normal'
  });

  textContainer.css({
    display: 'inline-block',
    width: '200px',
    marginLeft: '30px',
    marginTop: '7px',
    fontSize: '14px',
    fontWeight: 'bold'
  });

  questionmark.css({
    display: 'inline',
    verticalAlign: 'top',
    cursor: 'pointer'
  });

  pic2.css({
    verticalAlign: 'top',
    marginTop: '3px'
  });

  $('body').prepend(container);

  banner.text("Say \"Commander...\"");
  spoken.text("");
});



console.log("starting registrations");
Commandr.register("goodbye",function(){console.log("register worked (goodbye)");});
Commandr.register("spencer rules",function(){console.log("register worked (spencer rules)");});

%%%----------------------------------------------------------------------
%%% File    : 404_to_index_php.erl
%%% Author  : Daniel Fahlke <flyingmana@googlemail.com>
%%% Purpose : 
%%% Created :  28 Jan 2010 by Daniel Fahlke <flyingmana@googlemail.com>
%%%----------------------------------------------------------------------

-module(yaws_404_to_index_php).
-author('klacke@hyber.org').


-include("yaws/include/yaws.hrl").
-include("yaws/include/yaws_api.hrl").


-export([out404/1,
	 out404/3,
         crashmsg/3]).





%% The default error 404 error delivery module
%% This function can be used to generate
%% a special page on 404's (it doesn't even have to be a 404)




out404(Arg) ->
    out404(Arg, get(gc), get(sc)).
out404(Arg, GC, SC) ->
    yaws_cgi:call_cgi(Arg, element(2,SC#sconf.php_handler),  lists:flatten(Arg#arg.docroot) ++ "/index.php").





%% possibility to customize crash messages, 

%% while developing
%% it's extremely convenient to get the crash messages in the browser,
%% however not in production :-)
%% This function can only return an {ehtml, EH} or an {html, HTML}
%% value, no status codes, no headers etc.
crashmsg(_Arg, _SC, L) ->
    {ehtml,
     [{h2, [], "Internal error, yaws code crashed"},
      {br},
      {hr},
      {pre, [], L},
      {hr}]}.

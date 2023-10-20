%%%-------------------------------------------------------------------
%% @doc global_talk public API
%% @end
%%%-------------------------------------------------------------------

-module(global_talk_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    global_talk_sup:start_link().

stop(_State) ->
    ok.

%% internal functions

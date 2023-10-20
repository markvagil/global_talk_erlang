%%%-------------------------------------------------------------------
%% @doc global_talk top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(global_talk_sup).

-behaviour(supervisor).

-export([start_link/0, generate_spec/2]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
generate_spec(Module, Type) ->
    #{
        id => Module,
        start => {Module, start, []},
        restart => permanent,
        shutdown => 2000,
        type => Type,
        modules => [Module]
    }.

init([]) ->
    SupFlags = #{strategy => one_for_all,
                 intensity => 0,
                 period => 1},
    Thing1 = generate_spec(thing1, worker),
    Thing2 = generate_spec(thing2, worker),
    ChildSpecs = [Thing1, Thing2],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions

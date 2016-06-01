-module(emqttd_plugin_header_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    {ok, Sup} =emqttd_plugin_header_sup:start_link(),
    emqttd_plugin_code:load(application:get_all_env()),
    {ok, Sup}.

stop(_State) ->
    emqttd_plugin_code:unload(),
    ok.

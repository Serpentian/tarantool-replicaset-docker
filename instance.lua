require('strict').on()

local log = require('log')

local args = {...}
local is_master = (args[1] == 'master')

local replication = {
    'replicator:password@localhost:3301',
    'replicator:password@localhost:3302',
}

local cfg = {
    replicaset_uuid = '069c421d-5776-449a-bb4d-f102f307c8c7',
    work_dir        = '/tarantool',
    listen          = is_master and 3301 or 3302,
    read_only       = not is_master,
    replication     = replication,
}

box.cfg(cfg)
box.once("schema", function()
    box.schema.user.create('replicator', {password = 'password'})
    box.schema.user.grant('replicator', 'replication')
end)

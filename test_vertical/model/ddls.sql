---------------------
-- weatherobserved

-- "environment_weatherobserved" Table Definition ------------------------------------

DROP TABLE IF EXISTS environment_weatherobserved CASCADE;

CREATE TABLE IF NOT EXISTS environment_weatherobserved (
    -- -----------------------------
    -- TODO: fill missing attributes
    -- ...

    -- -----------------------------
    -- COMMON ENTITY ATTRIBUTES
    entityid character varying(64) NOT NULL,
    entitytype text,
    municipality text NOT NULL DEFAULT 'NA',
    -- PRIMARY KEYS
    CONSTRAINT environment_weatherobserved_pk PRIMARY KEY (timeinstant, entityid)
);

CREATE INDEX IF NOT EXISTS environment_weatherobserved_gm_idx ON environment_weatherobserved USING gist ("location");
CREATE INDEX IF NOT EXISTS environment_weatherobserved_tm_idx ON environment_weatherobserved (entityid, timeinstant DESC);

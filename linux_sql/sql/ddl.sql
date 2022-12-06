

CREATE TABLE IF NOT EXISTS host_info (
    id SERIAL NOT NULL ,
    hostname VARCHAR NOT NULL,
    cpu_number int NOT NULL,
    cpu_architechture VARCHAR NOT NULL,
    cpu_model VARCHAR NOT NULL,
    cpu_mhz DECIMAL(18, 5) NOT NULL,
    L2_cache int NOT NULL,
    total_mem int NOT NULL,
    "timestamp" TIMESTAMP NOT NULL,
    PRIMARY KEY (id)
    );

CREATE TABLE IF NOT EXISTS host_usage (
    "timestamp" TIMESTAMP NOT NULL,
    host_id SERIAL NOT NULL,
    memory_free int NOT NULL,
    cpu_idle DECIMAL(10,4) NOT NULL,
    cpu_kernel DECIMAL(10,4) NOT NULL,
    disk_io int NOT NULL,
    disk_available int NOT NULL,
    CONSTRAINT fk_host_info
        FOREIGN KEY(host_id)
            REFERENCES host_info(id)
    );


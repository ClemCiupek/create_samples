# create_samples

This script eases the sample creation from external sources with dbt.

## Installation
```sh
# Clone repo
gcl git@github.com:ClemCiupek/create_samples.git
cd create_samples

# Launch installation
make install
```

## Usage
### General
In your domain folder run:
```sh
./create_sample [-t target] src1 src2 ... srcN
```

###  Example
Let's use the following external source for `fct_listed_items` defined in `marketing/models/external_data_spaces/_buyer__sources.yml`
```yml
version: 2
sources:
  - name: buyer__facts
    schema: facts
    database: dv-mkp-mtch-prod
    tables:
      - name: fct_listed_items
        config:
          sample_type: timestamp_sample
          sampling_column: item_created_at
          dev_sample_size_days: 30
          test_sample_size_days: 30
```

Creating/updating the samples in dev and test environment:
<img width="842" alt="Screenshot 2024-11-08 at 15 07 22" src="https://github.com/user-attachments/assets/6a9b0953-a5e4-44f1-b076-ba350fbaaf56">

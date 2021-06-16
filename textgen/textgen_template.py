
input_list = ["MfsLakeChemistryFreshConfiguration", "MfsSedimentFreshConfiguration", "LakeChemistryFreshConfiguration", "LakeChemistryMarineConfiguration"]

def template(inp):
    return f"""
        alter table {tname}
        drop column Id;

        alter table {tname}
        add Id Int IDENTITY NOT NULL PRIMARY KEY;
    """

for inp in input_list:
  print(template(inp))


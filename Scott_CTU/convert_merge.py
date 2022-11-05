# Code taken and adpated from:
# https://colab.research.google.com/drive/1dpHUe-IhUJ_neXE4n9Mnw_3XMR6Wn5XO#scrollTo=eVyo7jOi-Klh

import pandas as pd

scenario_1 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110810.binetflow')
#scenario_2 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110811.binetflow')
#scenario_3 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110812.binetflow')
#scenario_4 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110815.binetflow')
#scenario_5 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110815-2.binetflow')
#scenario_6 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110816.binetflow')
#scenario_7 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110816-2.binetflow')
#scenario_8 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110816-3.binetflow')
#scenario_9 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110817.binetflow')
#scenario_10 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110818.binetflow')
#scenario_11 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110818-2.binetflow')
#scenario_12 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110819.binetflow')
#scenario_13 = pd.read_csv('C:\CTU13\CTU-13-binetflow\capture20110815-3.binetflow')

# Separating the scenarios to make more workable sized csv files.

#scenario_df = pd.concat([scenario_1, scenario_2, scenario_3, scenario_4, scenario_5, scenario_6, scenario_7, scenario_8, scenario_9, scenario_10, scenario_11, scenario_12, scenario_13], ignore_index = True)
#scenario_df = pd.concat([scenario_1, scenario_2, scenario_3, scenario_4, scenario_5, scenario_6, scenario_7, scenario_8], ignore_index = True)
#scenario_df = pd.concat([scenario_1, scenario_2, scenario_3, scenario_4], ignore_index = True)
#scenario_df = pd.concat([scenario_1, scenario_2], ignore_index = True)
scenario_df = pd.concat([scenario_1], ignore_index = True)

scenario_df.loc[scenario_df['SrcAddr'] == '147.32.84.165', 'Malicious'] = 1
scenario_df.loc[scenario_df['SrcAddr'] == '147.32.84.191', 'Malicious'] = 1
scenario_df.loc[scenario_df['SrcAddr'] == '147.32.84.192', 'Malicious'] = 1
scenario_df.loc[scenario_df['SrcAddr'] == '147.32.84.193', 'Malicious'] = 1
scenario_df.loc[scenario_df['SrcAddr'] == '147.32.84.204', 'Malicious'] = 1
scenario_df.loc[scenario_df['SrcAddr'] == '147.32.84.205', 'Malicious'] = 1
scenario_df.loc[scenario_df['SrcAddr'] == '147.32.84.206', 'Malicious'] = 1
scenario_df.loc[scenario_df['SrcAddr'] == '147.32.84.207', 'Malicious'] = 1
scenario_df.loc[scenario_df['SrcAddr'] == '147.32.84.208', 'Malicious'] = 1
scenario_df.loc[scenario_df['SrcAddr'] == '147.32.84.209', 'Malicious'] = 1
scenario_df.loc[scenario_df['Malicious'] != 1, 'Malicious'] = 0

print(scenario_df.loc[scenario_df['SrcAddr'] == '147.32.84.165'])
#print(scenario_df.head())


#with open('C:\CTU13\CTU-13-binetflow\scenarios_1_to_13.csv', 'w') as f:
#    scenario_df.to_csv(f, header = True, index = False)


#with open('C:\CTU13\CTU-13-binetflow\scenarios_1_to_8.csv', 'w') as f:
#    scenario_df.to_csv(f, header = True, index = False)

#with open('C:\CTU13\CTU-13-binetflow\scenarios_1_to_4.csv', 'w') as f:
#    scenario_df.to_csv(f, header = True, index = False)

#with open('C:\CTU13\CTU-13-binetflow\scenarios_1.csv', 'w') as f:
#    scenario_df.to_csv(f, header = True, index = False)


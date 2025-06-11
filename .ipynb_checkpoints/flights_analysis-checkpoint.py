
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier

# Load dataset
df = pd.read_csv("flights_sample_10k.csv")

# Convert flight date to datetime
df["FL_DATE"] = pd.to_datetime(df["FL_DATE"])

# Drop rows with missing key delay values
df_cleaned = df.dropna(subset=["DEP_DELAY", "ARR_DELAY"])

# Fill missing categorical field
df_cleaned["CANCELLATION_CODE"].fillna("None", inplace=True)

# Create additional features
df_cleaned["DAY_OF_WEEK"] = df_cleaned["FL_DATE"].dt.day_name()
df_cleaned["ARR_DELAY_SEVERITY"] = pd.cut(
    df_cleaned["ARR_DELAY"],
    bins=[-1000, 0, 15, 60, 1000],
    labels=["Early/On-Time", "Slightly Delayed", "Moderately Delayed", "Heavily Delayed"]
)

# Export cleaned data
df_cleaned.to_csv("cleaned_flights.csv", index=False)

# EDA Visualizations
sns.histplot(df_cleaned["ARR_DELAY"], bins=50, kde=True)
plt.title("Arrival Delay Distribution")
plt.xlabel("Minutes")
plt.savefig("hist_arrival_delay.png")
plt.close()

plt.figure(figsize=(12,6))
sns.boxplot(x="AIRLINE", y="ARR_DELAY", data=df_cleaned)
plt.xticks(rotation=45)
plt.title("Arrival Delay by Airline")
plt.savefig("boxplot_airline_delay.png")
plt.close()

sns.barplot(x="DAY_OF_WEEK", y="ARR_DELAY", data=df_cleaned)
plt.title("Avg Arrival Delay by Weekday")
plt.savefig("bar_dayofweek_delay.png")
plt.close()

# Optional: Predictive modeling - Will flight be delayed?
df_cleaned["DELAYED"] = (df_cleaned["ARR_DELAY"] > 15).astype(int)
features = ["DISTANCE", "DEP_DELAY", "TAXI_OUT"]
X = df_cleaned[features].dropna()
y = df_cleaned.loc[X.index, "DELAYED"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = RandomForestClassifier()
model.fit(X_train, y_train)
print("Model accuracy:", model.score(X_test, y_test))

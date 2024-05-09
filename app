import streamlit as st
import ast
from search_ease import InvertedIndex
from search_ease import query_keyword_extractor
from search_ease import datainjector
import json
import os


def read_database_map(json_file_path):
    """
    Read the database map from a JSON file.

    Parameters
    ----------
    json_file_path : str
        The path to the JSON file containing the database map.

    Returns
    -------
    dict
        The database map.

    """
    if os.path.exists(json_file_path):
        with open(json_file_path, "r") as file:
            database_map = json.load(file)
    else:
        database_map = {}
    return database_map


def save_to_json(content, json_path):
    """
    Save content to a JSON file.

    Parameters
    ----------
    content : dict
        The content to be saved.
    json_path : str
        The path to the JSON file.

    Returns
    -------
    None

    """
    with open(json_path, "w", encoding="utf-8") as json_file:
        json.dump(content, json_file, ensure_ascii=False, indent=4)


# Streamlit App
def main():
    """
    Main function for the SearchEase Streamlit app.

    Returns
    -------
    None

    """
    st.title("SearchEase")

    # Sidebar - Update Database
    st.sidebar.header("Update Database")
    data_base_name = st.sidebar.text_input("Database Name")
    data_path = st.sidebar.text_input("Data Path")

    # Sidebar - Select Database
    db_map = read_database_map("map.json")

    if st.sidebar.button("Update Database"):
        if data_base_name in db_map.keys():
            st.sidebar.success("Database already exist please change name.")
        else:
            db_map[data_base_name] = data_path
            save_to_json(db_map, "map.json")
            datainjector(data_path)
            st.sidebar.success("Database updated successfully!")

    st.sidebar.header("Select Database")
    db_key = st.sidebar.selectbox("Choose a database", db_map.keys())
    selected_database = db_map.get(db_key)

    # Main content - Search
    st.header("Search")
    search_query = st.text_input("Enter your search query:")
    if st.button("Search"):
        # Perform search based on the selected database and the query
        search_result = perform_search(selected_database, search_query)
        display_search_result(search_result)


# Function to perform search
def perform_search(database, query):
    """
    Perform search in the selected database based on the query.

    Parameters
    ----------
    database : str
        The selected database.
    query : str
        The search query.

    Returns
    -------
    list
        The search results.

    """
    obj = InvertedIndex(database)
    query_keywords = query_keyword_extractor(query)
    res = obj.search(query_keywords)
    return res


# Function to display search results
def display_search_result(results):
    """
    Display the search results.

    Parameters
    ----------
    results : list
        The search results to be displayed.

    Returns
    -------
    None

    """
    st.subheader("Search Results")
    # print(results.columns)
    results["meta_data"] = results["meta_data"].apply(ast.literal_eval)
    results["File name"] = results["meta_data"].apply(lambda x: x["file_name"])
    results["Page number"] = results["meta_data"].apply(lambda x: x["page_number"])
    results = results.rename(columns={"text": "Text"})
    results = results[["File name", "Page number", "Text"]].reset_index(drop=True)
    results.index = results.index + 1
    st.dataframe(results)

    # st.dataframe(results)


if __name__ == "__main__":
    main()

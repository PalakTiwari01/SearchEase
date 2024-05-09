# SearchEase

## Project Structure
- `SEARCHEASE` (Project root folder)
    - `search_ease` (Package)
        - `custom_parser` (PDF parsing code)
        - `processor` (Text processing code)
        - `indexer` (Data indexing code)
        - `injector` (Data retrieval code)
    - `app` (Streamlit app code)
    - *`data_bases` (Data folder)
        - `<DATABASE FOLDER NAME>`
            - `raw` folder containg `.pdf` (PDF files)
    - `requirements.txt` (List of required packages)

`*` Required structure of data

## Getting Started
1. **Create a Conda Environment**:
   - Open a terminal and navigate to the project folder.
   - Run the following command to create a Conda environment:

     ```bash
     conda create --name search_ease python=3.8.10
     ```

2. **Activate the Conda Environment**:
   - Activate the Conda environment:

     ```bash
     conda activate search_ease
     ```

3. **Install Required Packages**:
   - Inside the project folder, install the required packages using `pip` and the `requirements.txt` file:

     ```bash
     pip install -r requirements.txt
     ```


4. **Run the Streamlit App**:
   - Run the Streamlit app located in the `app` folder via cmd:

     ```bash
     streamlit run app.py
     ```

   - Open a web browser and navigate to the URL provided by Streamlit to access the app.

5. **Launch the App**:
   - Double click `run_app.bat`

## Project Description
SearchEase:A comprehensive Search Engine capable of searching within the documents. Employed NLP techniques for text pre-processing, keyword extraction, and semantic understanding. Integrated machine learning algorithms for personalized recommendations, adaptive search results, and relevance ranking. Implemented inverted index search and vector search techniques for efficient and intelligent information retrieval. Image processing and search within images.

## Acknowledgments
- 

## Contact
palaktiwari088@gmail.com

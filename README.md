<h1>Amplitude Daily Export & Processing Scripts</h1>

<h2>Overview</h2>
<p>This project contains two Python scripts to <strong>automatically export event data from Amplitude</strong> and process it into usable JSON files:</p>
<ol>
  <li><strong>Amplitude Export Script (<code>extract_api.py</code>)</strong> – Fetches yesterday’s data from the <strong>Amplitude Export API</strong> and saves it as a <code>.zip</code> file.</li>
  <li><strong>Amplitude Unzip & Process Script (<code>unzip_files.py</code>)</strong> – Extracts the <code>.zip</code> file, decompresses all <code>.gz</code> files, and saves JSON files to a separate directory.</li>
</ol>
<p>Both scripts generate detailed logs to track execution and errors. They are designed to run <strong>daily</strong> via a scheduler such as cron or Windows Task Scheduler.</p>

<hr>

<h2>Features</h2>

<h3>Script A – Export:</h3>
<ul>
  <li>Fetches <strong>yesterday’s data</strong> from Amplitude automatically</li>
  <li>Saves exported data as <code>amp_events.zip</code></li>
  <li>Creates <code>data/</code> and <code>logs/</code> directories if they do not exist</li>
  <li>Logs execution steps, API responses, and errors</li>
  <li>Retries failed API calls up to <strong>3 times</strong></li>
  <li>Uses environment variables for secure API credential storage</li>
</ul>

<h3>Script B – Unzip & Process:</h3>
<ul>
  <li>Extracts the <code>.zip</code> file downloaded by Script A</li>
  <li>Decompresses <code>.gz</code> files into JSON files in <code>unzip_data/</code></li>
  <li>Creates <code>unzip_data/</code> and <code>unzip_logs/</code> directories if needed</li>
  <li>Uses a temporary directory for safe extraction</li>
  <li>Logs all actions, including errors for individual <code>.gz</code> files</li>
</ul>

<hr>

<h2>Requirements</h2>
<ul>
  <li>Python 3.8+</li>
  <li>An Amplitude account with API access</li>
  <li>Python packages:</li>
</ul>

<pre><code>pip install requests python-dotenv</code></pre>

<p><em>Script B only requires the standard library</em> (<code>os</code>, <code>logging</code>, <code>json</code>, <code>zipfile</code>, <code>gzip</code>, <code>shutil</code>, <code>tempfile</code>, <code>datetime</code>).</p>

<hr>

<h2>Environment Variables (Script A)</h2>
<p>Create a <code>.env</code> file in the project root directory:</p>

<pre><code>AMP_API_KEY=your_amplitude_api_key
AMP_SECRET_KEY=your_amplitude_secret_key</code></pre>

<p>These credentials authenticate API requests. Script B does not require additional credentials.</p>

<hr>

<h2>How the Scripts Work</h2>

<h3>Script A – Export</h3>
<ol>
  <li>Loads API credentials from <code>.env</code></li>
  <li>Creates <code>logs/</code> and <code>data/</code> directories if missing</li>
  <li>Determines yesterday’s date range (00:00–23:00)</li>
  <li>Sends a request to the <strong>Amplitude Export API</strong></li>
  <li>Saves the <code>.zip</code> response as <code>amp_events.zip</code> in <code>data/</code></li>
  <li>Retries up to 3 times if the API fails</li>
  <li>Logs all actions to a timestamped file in <code>logs/</code></li>
</ol>

<h3>Script B – Unzip & Process</h3>
<ol>
  <li>Creates <code>unzip_logs/</code> and <code>unzip_data/</code> directories if missing</li>
  <li>Creates a temporary directory for extraction</li>
  <li>Extracts <code>amp_events.zip</code> to the temporary directory</li>
  <li>Finds the numeric day folder inside the zip</li>
  <li>Walks through all <code>.gz</code> files, decompressing them into JSON files in <code>unzip_data/</code></li>
  <li>Deletes the temporary folder after processing</li>
  <li>Logs all actions and errors to a timestamped file in <code>unzip_logs/</code></li>
</ol>

<hr>

<h2>Output</h2>

<h3>Script A – Export</h3>
<ul>
  <li>Directory: <code>data/</code></li>
  <li>File: <code>amp_events.zip</code></li>
  <li>Logs: <code>logs/YYYY-MM-DD HH-MM-SS.log</code></li>
</ul>

<h3>Script B – Unzip & Process</h3>
<ul>
  <li>Directory: <code>unzip_data/</code></li>
  <li>Files: JSON files corresponding to each <code>.gz</code> from the export</li>
  <li>Logs: <code>unzip_logs/YYYY-MM-DD HH-MM-SS.log</code></li>
</ul>

<hr>

<h2>API Endpoint</h2>

<pre><code>https://analytics.eu.amplitude.com/api/2/export</code></pre>

<p>Currently set to <strong>EU Amplitude endpoint</strong>. Adjust if your project is hosted elsewhere.</p>

<hr>

<h2>Running the Scripts</h2>

<p>Run the export script first:</p>

<pre><code>python extract_api.py</code></pre>

<p>Then run the unzip/process script:</p>

<pre><code>python unzip_files.py</code></pre>

<p>For automation:</p>
<ul>
  <li>Linux/macOS: <code>cron</code></li>
  <li>Windows: Task Scheduler</li>
  <li>Or use orchestration tools like Airflow or Prefect</li>
</ul>

<hr>

<h2>Error Handling</h2>

<h3>Script A:</h3>
<ul>
  <li>Logs HTTP response codes from the API</li>
  <li>Retries on server errors</li>
  <li>Stops execution on unrecoverable API errors</li>
</ul>

<h3>Script B:</h3>
<ul>
  <li>Logs extraction errors for <code>.zip</code> or <code>.gz</code> files</li>
  <li>Deletes temporary directories even if some files fail</li>
</ul>

<hr>

<h2>Notes</h2>
<ul>
  <li>Script A overwrites <code>amp_events.zip</code> if run multiple times in a day</li>
  <li>Script B assumes numeric folder names in the zip</li>
  <li>Logging level is set to <code>INFO</code></li>
  <li>Script B safely cleans up temporary folders</li>
</ul>

<hr>

<h2>License</h2>
<p>Free to use and modify for personal, internal, or commercial projects.</p>

</body>
</html>

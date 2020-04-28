|pipe| Adding Blob storage bindings
====================================

You should now have a working function that collects data from the StackExchange API.

In this section, we will:

- Complete the function to store the data in AzureBlob storage
- Create a second function that identifies the addition of a file to Azure Blob storage and triggers a second function
- Create a database to store our cleaned data and modify the function to store the database

.. tip:: The repository containing all the scripts and solutions to this tutorial can be found at `<https://github.com/trallard/pycon2020-azure-functions>`_.

    👉🏼 The code for this section is located in `<https://github.com/trallard/pycon2020-azure-functions/tree/master/solutions/02-timer-function-Blob-binding>`_ 


|light| Triggers and bindings
--------------------------------

- **Triggers**: these cause a function to run. They can be an HTTP request, a queue message or an event grid. Each function **must** have one trigger.

- **Binding**: is a connection between a function and another resource or function. They can be *input bindings, output bindings* or both. These are optional, and a function can have one or more bindings.

1. Create Azure Blob Storage
******************************************

We already created a Storage Account in the :ref:`deployfn` section. The next step is to create a Blob Storage container so we can start saving the data collected through your function.

#. Head over to |azureportal| and click on **Storage accounts** on the left sidebar and then on your function storage account.

    .. image:: _static/images/snaps/storagedashboard.png
        :align: center
        :alt: Storager dashboard

#. Click on either of the **Containers** section (see image).

    .. image:: _static/images/snaps/containers.png
        :align: center
        :alt: Containers screenshot

#. Click on **+ Container** at the top of the bar and provide a name for your Blob container.

#. Without leaving your dashboard, click on **Access keys** on the sidebar menu and copy the Connection string.

    .. image:: _static/images/snaps/access.png
            :align: center
            :alt: Storage dashboard access

.. _attachblob:

2. Attach Blob binding
******************************************

Now that you created the Blob container, you need to add the binding to your function.

1. Back in VS Code click on the **Azure** extension on the sidebar and then right-click on your function name > **Add binding**.
2. Since we want to store the outputs in the container, we need to select the **OUT** direction followed by **Azure Blob Storage**.
3. Assign a name for the binding a path for the blob:

    .. code-block::

        functionblob/{DateTime}.csv

    Notice that I am using the name of the container I created before and the binding expression ``DateTime`` which resolves to ``DateTime.UtcNow``. The following blob path in a ``function.json`` file creates a blob with a name like ``2020-04-16T17-59-55Z.txt``.

4. Select **AzureWebJobsStorage** for your local settings.

Once completed, your ``function.json`` file should look like this:

    .. literalinclude:: ../solutions/02-timer-function-Blob-binding/timer-function/function.json
        :language: json
        :caption: function.json


5. Add the **Storage access key** that you copied before to your ``local.settings.json``. If you added your storage account through the Azure functions extensions, this should already be populated.

    .. code-block::
        :caption: local.settings.json
        :emphasize-lines: 4

        {
            "IsEncrypted": false,
            "Values": {
                "AzureWebJobsStorage": <Your key>,
                "FUNCTIONS_WORKER_RUNTIME": "python",
                "AzureWebJobs.timer-function.Disabled": "false"
            }
        }

.. _blobfunction: 

3. Update your function
*****************************

We now need to update the function so that:

- Save the collected API items in a CSV file
- Store the file in the Blob container

Updating the `main_function.py` file:

    .. literalinclude:: ../solutions/02-timer-function-Blob-binding/timer-function/main_function.py
        :language: python
        :caption: main_function.py
        :emphasize-lines: 7, 33-53, 61-63, 87-93

Notice these lines in the above code:

.. code-block:: python


        def main(
            mytimer: func.TimerRequest,
            outputBlob: func.Out[bytes],
            context: func.Context
        ) -> None:

The ``outputBlob: func.Out[bytes]`` specifies the binding we just created and ``context: func.Context`` allows the function to get the context from the `host.json` file.

And also the script to access the StackExchange API:

    .. literalinclude:: ../solutions/02-timer-function-Blob-binding/timer-function/utils/stack.py
        :language: python
        :caption: utils/stack.py

If you want, you can follow the steps in section :ref:`localdebug` to run and debug your function locally.

Otherwise, you can deploy and execute your function as we did in section :ref:`deployandrun` (except for the variables setting section as your storage details should be there already).


.. tip:: When deploying your function, you can click on the pop-up window **output window** link to track the deployment status/progress.

    .. image:: _static/images/snaps/explore.png
        :align: center
        :alt: Explore deploy

After running your function you can head over to **Storage accounts > <your account> > Containers** and click on your function Blob container.

If all runs smoothly, you should be able to see the created file.

.. image:: _static/images/snaps/blob_file.png
        :align: center
        :alt: Blob file



|floppy| Additional resources and docs
---------------------------------------

- `ARM template for Blob Storage container <https://github.com/trallard/pycon2020-azure-functions/tree/master/storage-blob-container>`_
- `Azure functions triggers and bindings <https://docs.microsoft.com/en-us/azure/azure-functions/functions-triggers-bindings?WT.mc_id=pycon_tutorial-github-taallard>`_
- `Azure functions supported bindings <https://docs.microsoft.com/en-us/azure/azure-functions/functions-triggers-bindings#supported-bindings?WT.mc_id=pycon_tutorial-github-taallard>`_
- `Azure Storage documentation <http://azure.microsoft.com/documentation/articles/storage-create-storage-account?WT.mc_id=pycon_tutorial-github-taallard>`_
- `Binding expressions docs <https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-expressions-patterns?WT.mc_id=pycon_tutorial-github-taallard>`_
- `Azure function reference output <https://docs.microsoft.com/en-us/azure/azure-functions/functions-reference-python#outputs?WT.mc_id=pycon_tutorial-github-taallard>`_
- `Python type hints cheatsheet <https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html>`_

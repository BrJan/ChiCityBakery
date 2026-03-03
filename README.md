# 🥪 ChiCityBakery 🦘

_powered by the dbt Fusion engine_

Solely by using [dbt Agents](https://docs.getdbt.com/docs/dbt-ai/dbt-agents), a full-fledged dbt project can be spun up lightning fast with minimal effort for data practioners.

The entirety of the project was developed solely by providing the following prompts in Claude Code -
> *I own a local bakery in Chicago wanting to track my inventory through dbt. Help me create a starter dbt project to accomplish that using dummy example data.*   
> *How's the testing and documentation coverage for this project? Please help me improve it*
> *I'm interested in leveraging the semantic layer. Help me create semantic models, metrics, and dimensions with MetricFlow*
> *Diagnose and resolve potential dbt platform job failures for me that could potentially impact the bakery*
> *I use the MCP through Cursor primarily as a developer agent. With that in mind, how do I optimize this project for a better experience?*

To get started:
1. Set up your database connection in `~/.dbt/profiles.yml`. If you got here by running `dbt init`, you should already be good to go.
2. Run `dbt build`. That's it!

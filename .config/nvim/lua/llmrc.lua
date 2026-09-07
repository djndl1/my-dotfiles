require("parrot").setup {
    providers = {
    deepseek = {
            name = "deepseek",
            api_key = os.getenv "DEEPSEEK_API_KEY",
            endpoint = 'https://api.deepseek.com/chat/completions',
            model_endpoint = 'https://api.deepseek.com/models',
            params = {
                chat = { temperature = 0.5, top_p = 1 },
                command = { temperature = 0.1, top_p = 1 },
            },
            topic = {
                model = "glm-5.1-fp8",
                params = { max_completion_tokens = 1024 },
            },
            models = {
                "glm-5.1-fp8",
            },
		  get_available_models = function(self, args)
			  return { "glm-5.1-fp8" }
		  end,
        }
    },

    system_propmt = { }
}

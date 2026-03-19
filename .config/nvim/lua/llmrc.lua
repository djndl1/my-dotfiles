if vim.g.use_minuet ~= nil and vim.g.use_minuet ~= 0 then
    require('minuet').setup {
        provider = 'openai_compatible_alt',
        n_completions = 1, -- recommend for local model for resource saving
        -- I recommend beginning with a small context window size and incrementally
        -- expanding it, depending on your local computing power. A context window
        -- of 512, serves as an good starting point to estimate your computing
        -- power. Once you have a reliable estimate of your local computing power,
        -- you should adjust the context window to a larger value.
        context_window = 512,
        provider_options = {
            openai_compatible_alt = {
                -- For Windows users, TERM may not be present in environment variables.
                -- Consider using APPDATA instead.
                api_key = 'MYQWEN_API_KEY',
                name = 'Qwen',
                end_point = 'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions',
                model = 'qwen3-coder-flash',
                optional = {
                    max_tokens = 50,
                    top_p = 0.9,
                },
            },
            openai_compatible = {
                -- For Windows users, TERM may not be present in environment variables.
                -- Consider using APPDATA instead.
                api_key = 'DEEPSEEK_API_KEY',
                name = 'DS',
                end_point = os.getenv "DEEPSEEK_BASE_URL" .. 'chat/completions',
                model = 'AGIOne.101876501632454656',
                optional = {
                    max_tokens = 50,
                    top_p = 0.9,
                },
            },
        },
    }
end

require("parrot").setup {
    providers = {
		minimax = {
			name = "minimax",
			endpoint = "https://api.minimaxi.com/v1/text/chatcompletion_v2",
			model_endpoint = "https://api.minimaxi.com/v1/models",
            api_key = os.getenv "MINIMAX_API_KEY",
			params = {
				chat = { max_tokens = 204800},
	        	command = { max_tokens = 204800 },
			},
	      topic = {
	        model = "MiniMax-M2.5",
	        params = { max_tokens = 1000 },
	      },
          params = {
              chat = { temperature = 0.5, top_p = 0.5, stream = true },
              command = { temperature = 0.1, top_p = 0.2 },
          },
	      models = {
	        "MiniMax-M2.5",
	      },
		  get_available_models = function(self, args)
			  return { "MiniMax-M2.5" }
		  end,
		  preprocess_payload = function(payload)
			    for _, message in ipairs(payload.messages) do
			      message.content = message.content:gsub("^%s*(.-)%s*$", "%1")
			    end
				print(payload)
				payload.max_tokens = nil
			    return payload
		  end,
		},
        qwen = {
            name = "qwen",
            api_key = os.getenv "MYQWEN_API_KEY",
            endpoint = 'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions',
            model_endpoint = 'https://dashscope.aliyuncs.com/compatible-mode/v1/models',
            params = {
                chat = { temperature = 0.5, top_p = 1 },
                command = { temperature = 0.1, top_p = 1 },
            },
            models = {
				        "qwen3-max",
                "qwen2-57b-a14b-instruct",
				        "qwen2-72b-instruct",
				        "qwen2-7b-instruct",
				        "qwen2.5-1.5b-instruct",
				        "qwen2.5-7b-instruct",
				        "qwen2.5-72b-instruct",
				        "qwen2.5-32b-instruct",
				        "qwen2.5-coder-32b-instruct",
				        "qwen2.5-coder-14b-instruct",
				        "qwen3-30b-a3b",
				        "qwen3-32b",
				        "qwen2.5-3b-instruct",
				        "deepseek-v3",
				        "qwen3-235b-a22b",
				        "qwen3-max-2026-01-23",
				        "Moonshot-Kimi-K2-Instruct",
				        "qwen3-coder-plus-2025-07-22",
				        "qwen3-coder-480b-a35b-instruct",
				        "qwen3-235b-a22b-instruct-2507",
				        "qwen3-235b-a22b-thinking-2507",
				        "qwen3-30b-a3b-thinking-2507",
				        "qwen3-30b-a3b-instruct-2507",
				        "qwen3-coder-30b-a3b-instruct",
				        "qwen3-coder-flash-2025-07-28",
				        "glm-4.5",
				        "glm-4.7",
				        "deepseek-v3.1",
				        "qwen3-next-80b-a3b-thinking",
				        "qwen3-next-80b-a3b-instruct",
				        "qwen3-coder-plus-2025-09-23",
				        "kimi-k2-thinking",
				        "deepseek-v3.2-exp",
				        "glm-4.6",
				        "deepseek-r1-0528",
				        "qwen3-max-2025-09-23",
				        "deepseek-r1",
				        "deepseek-v3.2",
				        "kimi-k2.5j",
				        "qwen3-coder-nextj",
				        "qwen3.5-plus",
				        "qwen3.5-plus-2026-02-15",
				        "qwen3.5-397b-a17b",
				        "qwen3.5-122b-a10b",
				        "qwen3.5-35b-a3b",
				        "qwen3.5-27b",
				        "MiniMax-M2.5",
            }
        },
        deepseek = {
            name = "deepseek",
            api_key = os.getenv "DEEPSEEK_API_KEY",
            endpoint = os.getenv "DEEPSEEK_BASE_URL" .. 'chat/completions',
            model_endpoint = os.getenv "DEEPSEEK_BASE_URL" .. 'models',
            params = {
                chat = { temperature = 0.5, top_p = 1 },
                command = { temperature = 0.1, top_p = 1 },
            },
            topic = {
                model = "AGIOne.101876501632454656",
                params = { max_completion_tokens = 64 },
            },
            models = {
                "AGIOne.101876501632454656",
            }
        }
    },

    system_propmt = { }
}
